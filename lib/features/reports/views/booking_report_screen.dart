import 'dart:io';
import 'package:clinics/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
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
      Sheet sheetObject = excel['Booking Report'];
      
      // Headers
      sheetObject.appendRow([
        TextCellValue('Patient Name'),
        TextCellValue('Phone Number'),
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
          TextCellValue(booking.doctorName ?? 'N/A'),
          TextCellValue(formattedDate),
          TextCellValue(booking.time ?? 'N/A'),
          TextCellValue(booking.status?.name ?? 'N/A'),
        ]);
      }
      
      var fileBytes = excel.save();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/booking_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes!);
      
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Booking Report',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          BlocBuilder<BookingReportCubit, BookingReportState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (bookings) => IconButton(
                  icon: const Icon(Icons.file_download, color: Colors.black),
                  onPressed: () => _exportToExcel(bookings),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildFilters(),
              Expanded(
                child: BlocBuilder<BookingReportCubit, BookingReportState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(
                        child: Text('Initializing...', style: TextStyle(color: Colors.black54)),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                      success: (bookings) => _buildReportTable(bookings),
                      error: (message) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                message,
                                style: const TextStyle(color: Colors.black, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: _fetchReport,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                    label: 'From',
                    selectedDate: fromDate,
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
                  child: _buildDatePicker(
                    label: 'To',
                    selectedDate: toDate,
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
                    return CustomDropdownButtonFormField(
                      labelText: 'Filter by Doctor',
                      icon: Icons.person_outline,
                      value: _selectedDoctorName,
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('All Doctors'),
                        ),
                        ...(clinic.doctors ?? []).map((DoctorModel doctor) {
                          return DropdownMenuItem<String>(
                            value: doctor.name,
                            child: Text(
                              doctor.name ?? 'Unnamed Doctor',
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDoctorName = value;
                        });
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
                  child: const Text(
                    'Clear Filters',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker({required String label, DateTime? selectedDate, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54, fontSize: 10)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.black54),
                const SizedBox(width: 8),
                Text(
                  selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate) : 'Select',
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTable(List<ClinicBookingModel> bookings) {
    if (bookings.isEmpty) {
      return const Center(
        child: Text('No confirmed bookings found.', style: TextStyle(color: Colors.black54)),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Patient', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Doctor', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: bookings.map((booking) {
            String formattedDate = 'N/A';
            if (booking.date != null) {
              try {
                DateTime parsedDate = DateTime.parse(booking.date!);
                formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
              } catch (e) {
                formattedDate = booking.date!;
              }
            }
            
            return DataRow(cells: [
              DataCell(Text(booking.user?.username ?? 'N/A')),
              DataCell(Text(booking.user?.phoneno ?? 'N/A')),
              DataCell(Text(booking.doctorName ?? 'N/A')),
              DataCell(Text(formattedDate)),
              DataCell(Text(booking.time ?? 'N/A')),
              DataCell(Text(booking.status?.name ?? 'N/A')),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
