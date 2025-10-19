part of 'booking_cubit.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState.initial() = BookingInitial;
  const factory BookingState.loading() = BookingLoading;
  const factory BookingState.loaded(List<ClinicBookingModel> bookings) =
      BookingLoaded;
  const factory BookingState.success(String message) = BookingSuccess;
  const factory BookingState.error(String message) = BookingError;
}
