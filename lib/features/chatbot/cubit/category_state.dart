part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.success(List<CategoryModel> categories) =
      _Success;
  const factory CategoryState.failure(String? errorMessage) = _Failure;
}
