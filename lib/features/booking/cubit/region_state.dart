part of 'region_cubit.dart';

@freezed
class RegionState with _$RegionState {
  const factory RegionState.initial() = RegionInitial;
  const factory RegionState.loading() = RegionLoading;
  const factory RegionState.loaded(List<RegionModel> clinics) = RegionLoaded;
  const factory RegionState.error(String message) = RegionError;
}
