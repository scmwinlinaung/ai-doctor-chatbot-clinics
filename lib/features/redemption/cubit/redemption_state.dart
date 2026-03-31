import 'package:clinics/features/redemption/models/redemption_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'redemption_state.freezed.dart';

@freezed
class RedemptionState with _$RedemptionState {
  const factory RedemptionState.initial() = _Initial;
  const factory RedemptionState.loading() = _Loading;
  const factory RedemptionState.success(RedemptionResponseModel data) = _Success;
  const factory RedemptionState.error(String message) = _Error;
}
