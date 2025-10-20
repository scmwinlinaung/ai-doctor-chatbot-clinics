import 'package:clinics/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/core/widgets/custom_button.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/booking/cubit/booking_cubit.dart';
import 'package:clinics/features/booking/model/clinic_booking_model.dart';
import 'package:clinics/features/booking/model/doctor_model.dart';
import 'package:clinics/features/theme/cubit/theme_cubit.dart';
import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

// Helper class to pass filter data between the screen and the modal
class BookingFilters {
  final String? username;
  final String? phoneNumber;
  final BookingStatus? status;
  final String? fromDate;
  final String? toDate;

  BookingFilters({
    this.username,
    this.phoneNumber,
    this.status,
    this.fromDate,
    this.toDate,
  });
}

// Provider Wrapper for the screen
class BookingListingScreenProvider extends StatelessWidget {
  const BookingListingScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.instance<BookingCubit>()),
        BlocProvider(create: (context) => GetIt.instance<ClinicCubit>()),
      ],
      child: const BookingListingScreen(),
    );
  }
}

class BookingListingScreen extends StatefulWidget {
  const BookingListingScreen({super.key});

  @override
  State<BookingListingScreen> createState() => _BookingListingScreenState();
}

class _BookingListingScreenState extends State<BookingListingScreen> {
  // State to hold the currently applied filters
  BookingFilters _currentFilters = BookingFilters();

  @override
  void initState() {
    super.initState();
    // Fetch bookings when the screen loads
    context.read<BookingCubit>().fetchClinicBooking();
  }

  void _applyFilters(BookingFilters filters) {
    setState(() {
      _currentFilters = filters;
    });

    context.read<BookingCubit>().fetchClinicBooking(
          username: filters.username,
          phonenumber: filters.phoneNumber,
          status: filters.status,
          fromDate: filters.fromDate,
          toDate: filters.toDate,
        );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Filters applied successfully'),
          backgroundColor: Colors.green,
        ),
      );
  }

  void _showFilterModal() async {
    final result = await showModalBottomSheet<BookingFilters>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _FilterModalSheet(initialFilters: _currentFilters);
      },
    );

    if (result != null) {
      _applyFilters(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return BlocListener<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
            } else if (state is BookingError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Booking List',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.filter_list_rounded,
                    color: theme.primaryColor,
                  ),
                  onPressed: _showFilterModal,
                ),
              ],
            ),
            body: GradientBackground(
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const Center(child: LoadingWidget());
                  } else if (state is BookingLoaded) {
                    if (state.bookings.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No bookings found',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<BookingCubit>().fetchClinicBooking(
                              username: _currentFilters.username,
                              phonenumber: _currentFilters.phoneNumber,
                              status: _currentFilters.status,
                              fromDate: _currentFilters.fromDate,
                              toDate: _currentFilters.toDate,
                            );
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: state.bookings.length,
                        itemBuilder: (context, index) {
                          final booking = state.bookings[index];
                          return _buildBookingCard(context, booking, theme);
                        },
                      ),
                    );
                  } else if (state is BookingError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'Retry',
                            onPressed: () {
                              context.read<BookingCubit>().fetchClinicBooking();
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text("Initializing..."));
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingCard(
      BuildContext context, ClinicBookingModel booking, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking #${booking.id?.substring(0, 8) ?? 'N/A'}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _buildStatusChip(booking.status),
              ],
            ),
            const SizedBox(height: 12),
            if (booking.user != null) ...[
              _buildInfoRow('Patient', booking.user!.username ?? 'N/A', theme),
              _buildInfoRow('Phone', booking.user!.phoneno ?? 'N/A', theme),
            ],
            _buildInfoRow('Clinic ID', booking.clinic ?? 'N/A', theme),
            _buildInfoRow('Payment Status',
                booking.paid == true ? 'Paid' : 'Unpaid', theme),
            _buildInfoRow(
                'Booking Status', booking.status!.name.toString(), theme),
            if (booking.createdAt != null)
              _buildInfoRow('Created', _formatDate(booking.createdAt!), theme),
            const SizedBox(height: 16),
            if (booking.status == BookingStatus.booking) ...[
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Confirm',
                      color: Theme.of(context).primaryColor,
                      onPressed: () => _confirmBooking(
                          context, booking.id!, booking.clinic!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => _cancelBooking(context, booking.id!),
                    ),
                  ),
                ],
              ),
            ] else if (booking.status == BookingStatus.confirmed) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Text(
                  'Booking Confirmed',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.brightness == Brightness.dark
                    ? AppColors.darkSecondaryText
                    : AppColors.lightSecondaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BookingStatus? status) {
    Color color;
    String text;

    switch (status) {
      case BookingStatus.booking:
        color = Colors.orange;
        text = 'Pending';
        break;
      case BookingStatus.confirmed:
        color = Colors.green;
        text = 'Confirmed';
        break;
      default:
        color = Colors.grey;
        text = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (e) {
      return dateString;
    }
  }

  // UPDATED: Now opens the new modal
  void _confirmBooking(
      BuildContext context, String bookingId, String clinicId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: BlocProvider.of<BookingCubit>(context)),
            BlocProvider.value(value: BlocProvider.of<ClinicCubit>(context)),
          ],
          child: _ConfirmBookingModal(bookingId: bookingId, clinicId: clinicId),
        );
      },
    );
  }

  void _cancelBooking(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text(
            'Are you sure you want to cancel this booking? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('No'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<BookingCubit>().cancelBooking(bookingId);
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}

// Filter Modal is unchanged
class _FilterModalSheet extends StatefulWidget {
  // ...
  final BookingFilters initialFilters;
  const _FilterModalSheet({required this.initialFilters});

  @override
  State<_FilterModalSheet> createState() => _FilterModalSheetState();
}

class _FilterModalSheetState extends State<_FilterModalSheet>
    with SingleTickerProviderStateMixin {
  // ... all filter modal code is unchanged
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _fromDateController;
  late final TextEditingController _toDateController;

  // State
  BookingStatus? _selectedStatus;

  // Animation
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial filter values
    _usernameController =
        TextEditingController(text: widget.initialFilters.username);
    _phoneController =
        TextEditingController(text: widget.initialFilters.phoneNumber);
    _fromDateController =
        TextEditingController(text: widget.initialFilters.fromDate);
    _toDateController =
        TextEditingController(text: widget.initialFilters.toDate);
    _selectedStatus = widget.initialFilters.status;

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void _applyAndClose() {
    final filters = BookingFilters(
      username: _usernameController.text.trim().isEmpty
          ? null
          : _usernameController.text.trim(),
      phoneNumber: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      status: _selectedStatus,
      fromDate: _fromDateController.text.trim().isEmpty
          ? null
          : _fromDateController.text.trim(),
      toDate: _toDateController.text.trim().isEmpty
          ? null
          : _toDateController.text.trim(),
    );
    Navigator.of(context).pop(filters);
  }

  void _clearAndClose() {
    Navigator.of(context).pop(BookingFilters()); // Pop with empty filters
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 12,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modal Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Header
                  Text(
                    'Filter Bookings',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Form Fields (in a responsive single column)
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined)),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<BookingStatus>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(
                        labelText: 'Status',
                        prefixIcon: Icon(Icons.info_outline)),
                    items: BookingStatus.values.map((status) {
                      return DropdownMenuItem(
                          value: status,
                          child: Text(status.name.toUpperCase()));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedStatus = value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fromDateController,
                    decoration: const InputDecoration(
                        labelText: 'From Date (YYYY-MM-DD)',
                        prefixIcon: Icon(Icons.calendar_today_outlined)),
                    onTap: () => _selectDate(_fromDateController),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _toDateController,
                    decoration: const InputDecoration(
                        labelText: 'To Date (YYYY-MM-DD)',
                        prefixIcon: Icon(Icons.calendar_today_outlined)),
                    onTap: () => _selectDate(_toDateController),
                    readOnly: true,
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _clearAndClose,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Apply Filters',
                          onPressed: _applyAndClose,
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
      ),
    );
  }
}

// NEW: Modal for Confirming a Booking
class _ConfirmBookingModal extends StatefulWidget {
  final String bookingId;
  final String clinicId;

  const _ConfirmBookingModal({
    required this.bookingId,
    required this.clinicId,
  });

  @override
  State<_ConfirmBookingModal> createState() => _ConfirmBookingModalState();
}

class _ConfirmBookingModalState extends State<_ConfirmBookingModal> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDoctorId;
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  bool _isConfirming = false;

  @override
  void initState() {
    super.initState();
    // Fetch the specific clinic details to get the doctor list
    context.read<ClinicCubit>().getAClinicByID(widget.clinicId);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      _timeController.text = picked.format(context);
    }
  }

  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isConfirming = true;
      });
      context.read<BookingCubit>().confirmBooking(
            widget.bookingId,
            _selectedDoctorId!,
            _dateController.text,
            _timeController.text,
          );
      // The listener on the main screen will handle success/error and pop
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GradientBackground(
        child: Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 12,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Confirm Appointment',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(child: LoadingWidget()),
                    error: (message) => Center(
                      child: Text(
                        'Error loading doctors: $message',
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                    loaded: (clinic) {
                      // Using your CustomDropdownButtonFormField now
                      return CustomDropdownButtonFormField(
                        labelText: 'Assign Doctor',
                        icon: Icons.person_outline,
                        value: _selectedDoctorId,
                        items: (clinic.doctors ?? []).map((DoctorModel doctor) {
                          return DropdownMenuItem<String>(
                            value: doctor.id,
                            child: Text(
                              doctor.name ?? 'Unnamed Doctor',
                              // Important for long names
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDoctorId = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a doctor' : null,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Appointment Date",
                  prefixIcon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintStyle: const TextStyle(color: Colors.white70),
                  errorStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.redAccent,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.white38,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                onTap: _selectDate,
                readOnly: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a date'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Appointment Time",
                  prefixIcon:
                      const Icon(Icons.access_time, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintStyle: const TextStyle(color: Colors.white70),
                  errorStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.redAccent,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.white38,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                onTap: _selectTime,
                readOnly: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a time'
                    : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomButton(
                  text: 'Confirm Appointment',
                  isLoading: _isConfirming,
                  onPressed: _onConfirm,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
