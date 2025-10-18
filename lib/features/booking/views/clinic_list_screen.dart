import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:clinics/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:clinics/features/booking/cubit/book_cubit.dart';
import 'package:clinics/features/booking/cubit/city_cubit.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:clinics/features/booking/cubit/region_cubit.dart';
import 'package:clinics/features/booking/models/clinic_model.dart';

// Helper enum and class for managing filter state
enum SearchType { clinic, doctor, specialization }

class FilterResult {
  final String searchText;
  final SearchType searchType;
  final String? region;
  final String? city;

  FilterResult({
    required this.searchText,
    required this.searchType,
    this.region,
    this.city,
  });
}

class ClinicListScreen extends StatelessWidget {
  const ClinicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClinicCubit>(
          create: (context) =>
              GetIt.instance<ClinicCubit>()..fetchClinic("", "", "", "", ""),
        ),
        BlocProvider<CityCubit>(
          create: (context) => GetIt.instance<CityCubit>()..fetchCities(),
        ),
        BlocProvider<RegionCubit>(
          create: (context) => GetIt.instance<RegionCubit>()..fetchRegions(),
        ),
        BlocProvider<BookCubit>(
          create: (context) => GetIt.instance<BookCubit>(),
        ),
      ],
      child: const ClinicListView(),
    );
  }
}

class ClinicListView extends StatefulWidget {
  const ClinicListView({super.key});

  @override
  State<ClinicListView> createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  String? _expandedClinicId;

  // State to hold the currently applied filters
  FilterResult _currentFilters = FilterResult(
    searchText: '',
    searchType: SearchType.clinic,
    region: null,
    city: null,
  );

  void _applyFilters(FilterResult filters) {
    setState(() {
      _currentFilters = filters;
    });

    String? title, doctor, specialization;
    switch (filters.searchType) {
      case SearchType.clinic:
        title = filters.searchText;
        break;
      case SearchType.doctor:
        doctor = filters.searchText;
        break;
      case SearchType.specialization:
        specialization = filters.searchText;
        break;
    }

    context.read<ClinicCubit>().fetchClinic(
      title,
      doctor,
      specialization,
      filters.region == "All Regions" ? "" : filters.region,
      filters.city == "All Cities" ? "" : filters.city,
    );
  }

  void _showFilterModal() async {
    final result = await showModalBottomSheet<FilterResult>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        // Provide CityCubit and RegionCubit to the modal
        return _FilterModal(initialFilters: _currentFilters);
      },
    );

    if (result != null) {
      _applyFilters(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Find a Clinic',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_rounded,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: GradientBackground(
        child: BlocBuilder<ClinicCubit, ClinicState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text("Initializing...")),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(message, textAlign: TextAlign.center),
                ),
              ),
              loaded: (clinics) {
                if (clinics.isEmpty) {
                  return const Center(
                    child: Text(
                      "No clinics found matching your criteria.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => _applyFilters(_currentFilters),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: clinics.length,
                    itemBuilder: (context, index) {
                      final clinic = clinics[index];
                      final isExpanded = clinic.id == _expandedClinicId;

                      return ClinicCard(
                        clinic: clinic,
                        isExpanded: isExpanded,
                        onTap: () {
                          setState(() {
                            if (isExpanded) {
                              _expandedClinicId = null;
                            } else {
                              _expandedClinicId = clinic.id;
                            }
                          });
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FilterModal extends StatefulWidget {
  final FilterResult initialFilters;

  const _FilterModal({required this.initialFilters});

  @override
  State<_FilterModal> createState() => __FilterModalState();
}

class __FilterModalState extends State<_FilterModal> {
  late final TextEditingController _searchController;
  late SearchType _selectedSearchType;
  String? _selectedRegion;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.initialFilters.searchText,
    );
    _selectedSearchType = widget.initialFilters.searchType;
    _selectedRegion = widget.initialFilters.region;
    _selectedCity = widget.initialFilters.city;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedSearchType = SearchType.clinic;
      _selectedRegion = null;
      _selectedCity = null;
    });
  }

  void _applyAndClose() {
    final result = FilterResult(
      searchText: _searchController.text,
      searchType: _selectedSearchType,
      region: _selectedRegion,
      city: _selectedCity,
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                // Search Field
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Search Type Toggle
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<SearchType>(
                    segments: const [
                      ButtonSegment(
                        value: SearchType.clinic,
                        label: Text('Clinic'),
                        icon: Icon(Icons.local_hospital_outlined),
                      ),
                      ButtonSegment(
                        value: SearchType.doctor,
                        label: Text('Doctor'),
                        icon: Icon(Icons.person_outline),
                      ),
                      ButtonSegment(
                        value: SearchType.specialization,
                        label: Text('Specialization'),
                        icon: Icon(Icons.medical_services_outlined),
                      ),
                    ],
                    selected: {_selectedSearchType},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        _selectedSearchType = newSelection.first;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<CityCubit, CityState>(
                        builder: (context, state) {
                          final items = state.maybeWhen(
                            loaded: (cities) => [
                              "All Cities",
                              ...cities.map((c) => c.name),
                            ],
                            orElse: () => ["All Cities"],
                          );
                          return CustomDropdownButtonFormField(
                            labelText: 'City',
                            icon: Icons.location_city_rounded,
                            value: _selectedCity,
                            items: items
                                .map(
                                  (name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _selectedCity = value),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BlocBuilder<RegionCubit, RegionState>(
                        builder: (context, state) {
                          final items = state.maybeWhen(
                            loaded: (regions) => [
                              "All Regions",
                              ...regions.map((r) => r.name),
                            ],
                            orElse: () => ["All Regions"],
                          );
                          return CustomDropdownButtonFormField(
                            labelText: 'Region',
                            icon: Icons.location_on_outlined,
                            value: _selectedRegion,
                            items: items
                                .map(
                                  (name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _selectedRegion = value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearFilters,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Clear'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _applyAndClose,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// The ClinicCard widget remains unchanged.

class ClinicCard extends StatelessWidget {
  final ClinicModel clinic;
  final bool isExpanded;
  final VoidCallback onTap;

  const ClinicCard({
    super.key,
    required this.clinic,
    required this.isExpanded,
    required this.onTap,
  });

  // A beautifully designed success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your appointment has been booked successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Great!',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // A beautifully designed error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.red, size: 60),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Booking Failed',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Try Again',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shadowColor: Colors.blue.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCollapsedContent(context),
              if (isExpanded) _buildExpandedContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Image.network(
            clinic.image,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : const Center(child: LoadingWidget()),
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinic.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${clinic.city}, ${clinic.region}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey[600],
                size: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return BlocListener<BookCubit, BookState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => _showSuccessDialog(context),
          error: (message) => _showErrorDialog(context, message),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Doctors",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            if (clinic.doctors.isEmpty)
              const ListTile(title: Text("No doctors available"), dense: true)
            else
              ...clinic.doctors.map(
                (doctor) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctor.specialization,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  dense: true,
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            final tokenStorageService = TokenStorageService();
                            final userId = await tokenStorageService
                                .getUserId();

                            if (userId != null && context.mounted) {
                              context.read<BookCubit>().createBooking(
                                clinic.id,
                                userId,
                              );
                            } else if (context.mounted) {
                              _showErrorDialog(
                                context,
                                "User not found. Please log in again.",
                              );
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text("Book Appointment"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
