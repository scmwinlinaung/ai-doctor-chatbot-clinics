import 'package:clinics/core/util/date_util.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/reports/cubit/report_cubit.dart';
import 'package:clinics/features/reports/cubit/report_state.dart';
import 'package:clinics/features/reports/models/clinic_report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ClinicReportScreen extends StatefulWidget {
  final String clinicId;

  const ClinicReportScreen({super.key, required this.clinicId});

  @override
  State<ClinicReportScreen> createState() => _ClinicReportScreenState();
}

class _ClinicReportScreenState extends State<ClinicReportScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchReport();
  }

  void _fetchReport() {
    context.read<ReportCubit>().fetchClinicReport(
          clinicId: widget.clinicId,
          fromDate: fromDate != null ? DateFormat('yyyy-MM-dd').format(fromDate!) : null,
          toDate: toDate != null ? DateFormat('yyyy-MM-dd').format(toDate!) : null,
          username: _usernameController.text.isNotEmpty ? _usernameController.text : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Clinic Report',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildFilters(),
              Expanded(
                child: BlocBuilder<ReportCubit, ReportState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(
                        child: Text('Initializing...', style: TextStyle(color: Colors.black54)),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                      success: (data) => _buildReportContent(data),
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
            CustomTextField(
              controller: _usernameController,
              hintText: 'Filter by username',
              onChanged: (value) {
                // Debounce search if needed, but for now simple fetch
                _fetchReport();
              },
            ),
            if (fromDate != null || toDate != null || _usernameController.text.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      fromDate = null;
                      toDate = null;
                      _usernameController.clear();
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

  Widget _buildReportContent(ClinicReportModel data) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSummaryCards(data),
        const SizedBox(height: 24),
        const Text(
          'Redemption Details',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (data.redemptions == null || data.redemptions!.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.0),
              child: Text(
                'No redemptions match the filters.',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          )
        else
          ...data.redemptions!.map((redemption) => _buildRedemptionTile(redemption)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSummaryCards(ClinicReportModel data) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Points',
            data.totalPointsRedeemed?.toString() ?? '0',
            Icons.stars_rounded,
            Colors.orangeAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Total Count',
            data.totalRedemptions?.toString() ?? '0',
            Icons.receipt_long_rounded,
            Colors.cyanAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionTile(RedemptionDetail redemption) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  redemption.reward?.title ?? 'Unknown Reward',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.person, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      redemption.user?.username ?? 'N/A',
                      style: const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      redemption.redeemedAt != null ? DateUtil.formatToLocalDateTime(redemption.redeemedAt!) : 'N/A',
                      style: const TextStyle(color: Colors.black54, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Text(
                  '${redemption.points ?? 0} pts',
                  style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
