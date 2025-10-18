part of 'advertisement_cubit.dart';

@freezed
class AdvertisementState with _$AdvertisementState {
  const factory AdvertisementState.initial() = _Initial;
  const factory AdvertisementState.loading() = _Loading;
  const factory AdvertisementState.success(
      List<AdvertisementModel> advertisements) = _Success;
  const factory AdvertisementState.failure(String? errorMessage) = _Failure;
}
