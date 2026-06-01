import 'dart:io';
import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:clinics/core/widgets/searchable_grouped_doctor_dropdown.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:clinics/features/booking/model/clinic_booking_model.dart';
import 'package:clinics/features/booking/model/doctor_model.dart';
import 'package:clinics/features/reports/cubit/booking_report_cubit.dart';
import 'package:clinics/features/reports/cubit/booking_report_state.dart';
import 'package:excel/excel.dart' hide Border;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class BookingReportScreen extends StatelessWidget {
  const BookingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ClinicCubit>(),
      child: const _BookingReportScreenContent(),
    );
  }
}

class _BookingReportScreenContent extends StatefulWidget {
  const _BookingReportScreenContent();

  @override
  State<_BookingReportScreenContent> createState() => _BookingReportScreenContentState();
}

class _BookingReportScreenContentState extends State<_BookingReportScreenContent> {
  DateTime? fromDate;
  DateTime? toDate;
  String? _selectedDoctorName;

  @override
  void initState() {
    super.initState();
    _loadClinicData();
    _fetchReport();
  }
  
  Future<void> _loadClinicData() async {
    final tokenStorage = GetIt.instance<TokenStorageService>();
    final clinicId = await tokenStorage.getClinicId();
    if (clinicId != null && mounted) {
      context.read<ClinicCubit>().getAClinicByID(clinicId);
    }
  }

  void _fetchReport() {
    context.read<BookingReportCubit>().fetchBookingReport(
          doctorName: _selectedDoctorName,
          fromDate: fromDate != null ? DateFormat('yyyy-MM-dd').format(fromDate!) : null,
          toDate: toDate != null ? DateFormat('yyyy-MM-dd').format(toDate!) : null,
        );
  }

  Future<void> _exportToExcel(List<ClinicBookingModel> bookings) async {
    try {
      var excel = Excel.createExcel();
      String sheetName = 'Booking Report';
      excel.rename('Sheet1', sheetName);
      Sheet sheetObject = excel[sheetName];
      
      sheetObject.appendRow([
        TextCellValue('Patient'),
        TextCellValue('Phone Number'),
        TextCellValue('Patient Name'),
        TextCellValue('Age'),
        TextCellValue('Doctor Name'),
        TextCellValue('Date'),
        TextCellValue('Time'),
        TextCellValue('Status'),
      ]);
      
      for (var booking in bookings) {
        String formattedDate = 'N/A';
        if (booking.date != null) {
          try {
             DateTime parsedDate = DateTime.parse(booking.date!);
             formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
          } catch (e) {
             formattedDate = booking.date!;
          }
        }
        
        sheetObject.appendRow([
          TextCellValue(booking.user?.username ?? 'N/A'),
          TextCellValue(booking.user?.phoneno ?? 'N/A'),
          TextCellValue(booking.patientName ?? 'N/A'),
          TextCellValue(booking.age?.toString() ?? 'N/A'),
          TextCellValue(booking.doctorName ?? 'N/A'),
          TextCellValue(formattedDate),
          TextCellValue(booking.time ?? 'N/A'),
          TextCellValue(booking.status?.name ?? 'N/A'),
        ]);
      }
      
      var fileBytes = excel.save(fileName: 'booking_report.xlsx');
      if (fileBytes == null) throw Exception('Failed to generate Excel file bytes');

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/booking_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report exported to $filePath')),
        );
      }
      
      await OpenFilex.open(filePath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to export: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Booking Analytics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          BlocBuilder<BookingReportCubit, BookingReportState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (bookings) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton.icon(
                    onPressed: () => _exportToExcel(bookings),
                    icon: const Icon(Icons.file_download_outlined, size: 20),
                    label: const Text('Export'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: BlocBuilder<BookingReportCubit, BookingReportState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  success: (bookings) => _buildReportList(bookings),
                  error: (message) => _buildErrorState(message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildFilterChip(
                  label: 'From Date',
                  value: fromDate != null ? DateFormat('MMM dd, yyyy').format(fromDate!) : 'Select Start',
                  icon: Icons.calendar_today_outlined,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: fromDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => fromDate = picked);
                      _fetchReport();
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterChip(
                  label: 'To Date',
                  value: toDate != null ? DateFormat('MMM dd, yyyy').format(toDate!) : 'Select End',
                  icon: Icons.event_available_outlined,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: toDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => toDate = picked);
                      _fetchReport();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<ClinicCubit, ClinicState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (clinic) {
                  return SearchableGroupedDoctorDropdown(
                    labelText: 'Filter by Doctor',
                    icon: Icons.person_outline,
                    value: _selectedDoctorName,
                    valueType: 'name',
                    showAllOption: true,
                    isDark: false,
                    doctors: clinic.doctors ?? [],
                    onChanged: (doctor) {
                      setState(() => _selectedDoctorName = doctor?.name);
                      _fetchReport();
                    },
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          if (fromDate != null || toDate != null || _selectedDoctorName != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    fromDate = null;
                    toDate = null;
                    _selectedDoctorName = null;
                  });
                  _fetchReport();
                },
                child: const Text('Reset Filters', style: TextStyle(color: Colors.redAccent)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required String label, required String value, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.lightSecondaryText, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(icon, size: 16, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportList(List<ClinicBookingModel> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text('No bookings found for selected criteria', style: TextStyle(color: AppColors.lightSecondaryText)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account: ${booking.user?.username ?? 'N/A'}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              if (booking.patientName != null && booking.patientName!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Patient: ${booking.patientName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.primaryColor.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        _buildStatusBadge(booking.status?.name ?? 'N/A'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildDetailItem(Icons.phone_outlined, booking.user?.phoneno ?? 'N/A'),
                        const SizedBox(width: 24),
                        _buildDetailItem(Icons.cake_outlined, '${booking.age ?? 'N/A'} yrs'),
                      ],
                    ),
                    const Divider(height: 24, thickness: 0.5),
                    Row(
                      children: [
                        Expanded(child: _buildDetailItem(Icons.medical_services_outlined, booking.doctorName ?? 'General')),
                        _buildDetailItem(Icons.calendar_today_outlined, booking.date != null ? DateFormat('MMM dd').format(DateTime.parse(booking.date!)) : 'N/A'),
                        const SizedBox(width: 16),
                        _buildDetailItem(Icons.access_time_rounded, booking.time ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.lightSecondaryText),
        const SizedBox(width: 6),
        Text(value, style: const TextStyle(fontSize: 13, color: AppColors.lightPrimaryText)),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'confirmed':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = AppColors.primaryColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _fetchReport, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
