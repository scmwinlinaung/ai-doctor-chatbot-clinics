part of 'book_cubit.dart';

@freezed
class BookState with _$BookState {
  const factory BookState.initial() = BookInitial;
  const factory BookState.loading() = BookLoading;
  const factory BookState.success() = BookSuccess;
  const factory BookState.error(String message) = BookError;
}
