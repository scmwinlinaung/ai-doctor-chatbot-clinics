part of 'clinic_cubit.dart';

@freezed
class ClinicState with _$ClinicState {
  const factory ClinicState.initial() = ClinicInitial;
  const factory ClinicState.loading() = ClinicLoading;
  const factory ClinicState.loaded(ClinicModel clinics) = ClinicLoaded;
  const factory ClinicState.error(String message) = ClinicError;
}
