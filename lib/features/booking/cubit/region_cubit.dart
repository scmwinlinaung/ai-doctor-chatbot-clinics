import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/features/booking/models/region_model.dart';
import 'package:injectable/injectable.dart';

part 'region_state.dart';
part 'region_cubit.freezed.dart';

@injectable
class RegionCubit extends Cubit<RegionState> {
  RegionCubit() : super(const RegionState.initial());
  final Dio _dio = DioClient.instance;
  Future<void> fetchRegions() async {
    try {
      emit(const RegionState.loading());
      final response = await _dio.get('/regions');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data as List;
        final List<RegionModel> cities = responseData
            .map((json) => RegionModel.fromJson(json as Map<String, dynamic>))
            .toList();
        emit(RegionState.loaded(cities));
      } else {
        emit(const RegionState.error('Failed to fetch region data'));
      }
    } catch (e) {
      emit(RegionState.error('Unexpected error: ${e.toString()}'));
    }
  }
}
