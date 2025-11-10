import 'package:clinics/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:clinics/features/home/views/user_settings_screen.dart';
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
import 'package:clinics/core/util/date_util.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// Enum to manage the current view state for the toggle buttons
enum BookingView { booking, confirmed }

// Helper class to pass filter data between the screen and the modal
class BookingFilters {
  final String? doctorname;
  final String? username;
  final String? phoneNumber;
  final BookingStatus? status;
  final String? fromDate;
  final String? toDate;

  BookingFilters({
    this.doctorname,
    this.username,
    this.phoneNumber,
    this.status,
    this.fromDate,
    this.toDate,
  });
}

// Provider Wrapper for the screen
class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

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
  // State variable to control which list is shown (Pending Bookings vs. Confirmed)
  BookingView _currentView = BookingView.booking;

  @override
  void initState() {
    super.initState();
    // Fetch all bookings when the screen loads
    context.read<BookingCubit>().fetchClinicBooking();
  }

  void _applyFilters(BookingFilters filters) {
    setState(() {
      _currentFilters = filters;
    });

    context.read<BookingCubit>().fetchClinicBooking(
          doctorname: filters.doctorname,
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

  // Helper method to launch the phone dialer
  void _launchPhoneDialer(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number is not available.')),
      );
      return;
    }
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Could not launch phone dialer for $phoneNumber')),
      );
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
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.jpg'),
                    ),
                  );
                },
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
            drawer: const Drawer(
              child: UserSettingsScreen(),
            ),
            // Body is now a Column to hold the toggle buttons and the list
            body: Column(
              children: [
                // The "Booking" and "Confirm" toggle buttons
                _buildToggleButtons(theme),
                // Expanded ensures the list below fills the remaining screen space
                Expanded(
                  child: GradientBackground(
                    child: BlocBuilder<BookingCubit, BookingState>(
                      builder: (context, state) {
                        if (state is BookingLoading) {
                          return const Center(child: LoadingWidget());
                        } else if (state is BookingLoaded) {
                          // Filter the full list locally based on the selected view
                          final displayedBookings =
                              state.bookings.where((booking) {
                            if (_currentView == BookingView.booking) {
                              return booking.status == BookingStatus.booking;
                            } else {
                              return booking.status == BookingStatus.confirmed;
                            }
                          }).toList();

                          if (displayedBookings.isEmpty) {
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
                                    // Show a dynamic message based on the view
                                    _currentView == BookingView.booking
                                        ? 'No pending bookings found'
                                        : 'No confirmed bookings found',
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 16),
                                  CustomButton(
                                    text: 'Retry',
                                    onPressed: () {
                                      context
                                          .read<BookingCubit>()
                                          .fetchClinicBooking();
                                    },
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
                            // Build the list using the locally filtered data
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              itemCount: displayedBookings.length,
                              itemBuilder: (context, index) {
                                final booking = displayedBookings[index];
                                return _buildBookingCard(
                                    context, booking, theme);
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
                                    context
                                        .read<BookingCubit>()
                                        .fetchClinicBooking();
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
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget for the "Booking" / "Confirm" toggle buttons
  Widget _buildToggleButtons(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              child: CustomButton(
            borderColor: Colors.grey,
            color: _currentView == BookingView.booking
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            textColor: _currentView == BookingView.booking
                ? Colors.white
                : Colors.black,
            text: 'Booking',
            onPressed: () {
              setState(() {
                _currentView = BookingView.booking;
              });
            }, // Already selected, do nothing
          )),
          const SizedBox(width: 12),
          Expanded(
              child: CustomButton(
            borderColor: Colors.grey,
            color: _currentView == BookingView.confirmed
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            textColor: _currentView == BookingView.confirmed
                ? Colors.white
                : Colors.black,
            text: 'Confirm',
            onPressed: () {
              setState(() {
                _currentView = BookingView.confirmed;
              });
            }, // Already selected, do nothing
          )),
        ],
      ),
    );
  }

  // Widget to build a single booking card in the list
  Widget _buildBookingCard(
      BuildContext context, ClinicBookingModel booking, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(top: 16.0),
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
              _buildInfoRow('Patient', booking.user?.username ?? 'N/A', theme),
              InkWell(
                onTap: () => _launchPhoneDialer(booking.user!.phoneno),
                child: _buildInfoRow(
                  'Phone',
                  booking.user?.phoneno ?? 'N/A',
                  theme,
                  isLink: true,
                ),
              ),
            ],
            // Conditionally show doctor and date for confirmed bookings
            if (booking.doctorName != null)
              _buildInfoRow(
                  'Doctor Name', booking.doctorName.toString(), theme),
            if (booking.confirmedDate != null)
              _buildInfoRow(
                  'Confirmed Date',
                  "${DateUtil.formatStringToDateOnly(booking.confirmedDate.toString())} ${booking.time!}",
                  theme),
            _buildInfoRow(
                'Booking Status', booking.status!.name.toString(), theme),

            if (booking.createdAt != null)
              _buildInfoRow(
                  'Created',
                  DateUtil.formatStringToLocalDateTime(booking.createdAt!),
                  theme),
            const SizedBox(height: 16),

            // Show "Confirm" button only for pending bookings
            if (booking.status == BookingStatus.booking) ...[
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Confirm',
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      _confirmBooking(context, booking.id!, booking.clinic!),
                ),
              ),
            ]
            // Show buttons for confirmed bookings
            else if (booking.status == BookingStatus.confirmed) ...[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Text(
                        'Booking Confirmed',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: () => _bookAgain(context, booking),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Book Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _isConfirmedYesterday(String? confirmedDate) {
    if (confirmedDate == null) return false;

    try {
      final date = DateTime.parse(confirmedDate);
      final now = DateTime.now();
      final yesterdayConfirmed = date.subtract(const Duration(days: 1));
      // Compare only the date part (ignoring time)
      return now.year == yesterdayConfirmed.year &&
          now.month == yesterdayConfirmed.month &&
          now.day == yesterdayConfirmed.day;
    } catch (e) {
      return false;
    }
  }

  // Helper widget for a label-value row
  Widget _buildInfoRow(String label, String value, ThemeData theme,
      {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
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
                color: isLink ? Colors.blue : null,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
          if (label == 'Confirmed Date' && _isConfirmedYesterday(value))
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 22,
            ),
        ],
      ),
    );
  }

  // Helper widget for the status chip (Pending/Confirmed)
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

  // Shows the confirmation modal sheet
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

  // Shows the book again modal for confirmed bookings
  void _bookAgain(BuildContext context, ClinicBookingModel booking) {
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
          child: _BookAgainModal(booking: booking),
        );
      },
    );
  }
}

// The Filter Modal Sheet (unchanged)
class _FilterModalSheet extends StatefulWidget {
  final BookingFilters initialFilters;
  const _FilterModalSheet({required this.initialFilters});

  @override
  State<_FilterModalSheet> createState() => _FilterModalSheetState();
}

class _FilterModalSheetState extends State<_FilterModalSheet>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _doctorController;
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _fromDateController;
  late final TextEditingController _toDateController;
  BookingStatus? _selectedStatus;
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _doctorController =
        TextEditingController(text: widget.initialFilters.doctorname);
    _usernameController =
        TextEditingController(text: widget.initialFilters.username);
    _phoneController =
        TextEditingController(text: widget.initialFilters.phoneNumber);
    _fromDateController =
        TextEditingController(text: widget.initialFilters.fromDate);
    _toDateController =
        TextEditingController(text: widget.initialFilters.toDate);
    _selectedStatus = widget.initialFilters.status;

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
    _doctorController.dispose();
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
      doctorname: _doctorController.text.trim().isEmpty
          ? null
          : _doctorController.text.trim(),
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
    Navigator.of(context).pop(BookingFilters());
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
                    'Filter Bookings',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _doctorController,
                    decoration: const InputDecoration(
                        labelText: 'Doctor',
                        prefixIcon: Icon(Icons.person_outline)),
                  ),
                  const SizedBox(height: 24),
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
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Clear'),
                          onPressed: _clearAndClose,
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

// The Confirm Booking Modal (unchanged)
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
                      return CustomDropdownButtonFormField(
                        labelText: 'Assign Doctor',
                        icon: Icons.person_outline,
                        value: _selectedDoctorId,
                        items: (clinic.doctors ?? []).map((DoctorModel doctor) {
                          return DropdownMenuItem<String>(
                            value: doctor.id,
                            child: Text(
                              doctor.name ?? 'Unnamed Doctor',
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

// The Book Again Modal for confirmed bookings
class _BookAgainModal extends StatefulWidget {
  final ClinicBookingModel booking;

  const _BookAgainModal({
    required this.booking,
  });

  @override
  State<_BookAgainModal> createState() => _BookAgainModalState();
}

class _BookAgainModalState extends State<_BookAgainModal> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDoctorId;
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  bool _isBooking = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with existing booking data if available
    if (widget.booking.clinic != null) {
      context.read<ClinicCubit>().getAClinicByID(widget.booking.clinic!);
    }
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

  void _onBookAgain() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isBooking = true;
      });

      // Create a new booking using the confirmBooking API
      // We'll use the original booking ID to create a new booking with same details
      context.read<BookingCubit>().confirmBooking(
            widget.booking.id!,
            _selectedDoctorId!,
            _dateController.text,
            _timeController.text,
          );
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
                'Book Appointment Again',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Book a new appointment with the same details',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Patient info display
              if (widget.booking.user != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Information',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Name: ${widget.booking.user?.username ?? 'N/A'}'),
                      Text('Phone: ${widget.booking.user?.phoneno ?? 'N/A'}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

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
                      return CustomDropdownButtonFormField(
                        labelText: 'Assign Doctor',
                        icon: Icons.person_outline,
                        value: _selectedDoctorId,
                        items: (clinic.doctors ?? []).map((DoctorModel doctor) {
                          return DropdownMenuItem<String>(
                            value: doctor.id,
                            child: Text(
                              doctor.name ?? 'Unnamed Doctor',
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
                  text: 'Book New Appointment',
                  isLoading: _isBooking,
                  onPressed: _onBookAgain,
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
