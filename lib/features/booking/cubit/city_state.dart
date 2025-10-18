part of 'city_cubit.dart';

@freezed
class CityState with _$CityState {
  const factory CityState.initial() = CityInitial;
  const factory CityState.loading() = CityLoading;
  const factory CityState.loaded(List<CityModel> clinics) = CityLoaded;
  const factory CityState.error(String message) = CityError;
}
