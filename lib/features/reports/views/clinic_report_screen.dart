import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/util/date_util.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
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
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Clinic Overview',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  success: (data) => _buildReportContent(data),
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
                  label: 'Start Date',
                  value: fromDate != null ? DateFormat('MMM dd, yyyy').format(fromDate!) : 'Start',
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
                  label: 'End Date',
                  value: toDate != null ? DateFormat('MMM dd, yyyy').format(toDate!) : 'End',
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
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Search by username...',
                prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: (_) => _fetchReport(),
            ),
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
                child: const Text('Reset All', style: TextStyle(color: Colors.redAccent)),
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
                Icon(icon, size: 14, color: AppColors.primaryColor),
                const SizedBox(width: 6),
                Expanded(child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis))),
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
        _buildSummarySection(data),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Redemptions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.lightPrimaryText),
            ),
            if (data.redemptions != null && data.redemptions!.isNotEmpty)
              Text(
                '${data.redemptions!.length} records',
                style: const TextStyle(fontSize: 12, color: AppColors.lightSecondaryText),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (data.redemptions == null || data.redemptions!.isEmpty)
          _buildEmptyState()
        else
          ...data.redemptions!.map((redemption) => _buildRedemptionCard(redemption)),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSummarySection(ClinicReportModel data) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Points Redeemed',
            data.totalPointsRedeemed?.toString() ?? '0',
            Icons.stars_rounded,
            const Color(0xFFF39C12),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Total Transactions',
            data.totalRedemptions?.toString() ?? '0',
            Icons.receipt_long_rounded,
            const Color(0xFF2ECC71),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 20),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.lightPrimaryText),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.lightSecondaryText, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionCard(RedemptionDetail redemption) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.redeem_rounded, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  redemption.reward?.title ?? 'Unknown Reward',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.lightPrimaryText),
                ),
                const SizedBox(height: 4),
                Text(
                  'User: ${redemption.user?.username ?? 'N/A'}',
                  style: const TextStyle(fontSize: 13, color: AppColors.lightSecondaryText),
                ),
                const SizedBox(height: 4),
                Text(
                  redemption.redeemedAt != null ? DateFormat('MMM dd, yyyy • HH:mm').format(redemption.redeemedAt!) : 'N/A',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF39C12).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${redemption.points ?? 0} pts',
              style: const TextStyle(color: Color(0xFFF39C12), fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Icon(Icons.history_rounded, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text('No redemptions found', style: TextStyle(color: AppColors.lightSecondaryText)),
          ],
        ),
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
