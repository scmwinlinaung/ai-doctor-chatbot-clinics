import 'package:clinics/features/reports/cubit/report_state.dart';
import 'package:clinics/features/reports/services/report_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  final ReportService _reportService;

  ReportCubit(this._reportService) : super(const ReportState.initial());

  Future<void> fetchClinicReport({
    required String clinicId,
    String? fromDate,
    String? toDate,
    String? username,
  }) async {
    emit(const ReportState.loading());
    try {
      final response = await _reportService.getClinicReport(
        clinicId: clinicId,
        fromDate: fromDate,
        toDate: toDate,
        username: username,
      );
      emit(ReportState.success(response));
    } catch (e) {
      emit(ReportState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
