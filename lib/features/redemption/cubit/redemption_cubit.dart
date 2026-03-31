import 'package:clinics/features/redemption/cubit/redemption_state.dart';
import 'package:clinics/features/redemption/models/redemption_request_model.dart';
import 'package:clinics/features/redemption/services/redemption_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RedemptionCubit extends Cubit<RedemptionState> {
  final RedemptionService _redemptionService;

  RedemptionCubit(this._redemptionService) : super(const RedemptionState.initial());

  Future<void> verifyRedemptionCode(String redemptionCode) async {
    emit(const RedemptionState.loading());
    try {
      final request = RedemptionRequestModel(redemptionCode: redemptionCode);
      final response = await _redemptionService.verifyRedemptionCode(request);
      emit(RedemptionState.success(response));
    } catch (e) {
      emit(RedemptionState.error(e.toString()));
    }
  }

  void reset() {
    emit(const RedemptionState.initial());
  }
}
