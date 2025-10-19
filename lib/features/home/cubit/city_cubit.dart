import 'package:clinics/features/home/models/city_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:injectable/injectable.dart';

part 'city_state.dart';
part 'city_cubit.freezed.dart';

@injectable
class CityCubit extends Cubit<CityState> {
  CityCubit() : super(const CityState.initial());
  final Dio _dio = DioClient.instance;
  Future<void> fetchCities() async {
    try {
      emit(const CityState.loading());
      final response = await _dio.get('/cities');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data as List;
        final List<CityModel> cities = responseData
            .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
            .toList();
        emit(CityState.loaded(cities));
      } else {
        emit(const CityState.error('Failed to fetch city data'));
      }
    } catch (e) {
      emit(CityState.error('Unexpected error: ${e.toString()}'));
    }
  }
}
