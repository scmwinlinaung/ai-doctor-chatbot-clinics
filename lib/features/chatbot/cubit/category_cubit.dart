import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/features/chatbot/models/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState.initial());

  Future<void> fetchCategories(String search) async {
    emit(const CategoryState.loading());
    try {
      var apiUrl = ApiRoute.categories;
      if (search.isNotEmpty) {
        apiUrl += "?categoryName=$search&subcategoryName=$search";
      }
      final Response response = await DioClient.instance.get(apiUrl);
      final dynamic data = response.data;
      final List<CategoryModel> categories = (data as List<dynamic>)
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();

      emit(CategoryState.success(categories));
    } catch (error) {
      emit(CategoryState.failure(error.toString()));
    }
  }
}
