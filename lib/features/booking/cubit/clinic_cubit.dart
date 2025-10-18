import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/booking/models/clinic_model.dart';
import 'package:injectable/injectable.dart';

part 'clinic_state.dart';
part 'clinic_cubit.freezed.dart';

@injectable
class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(const ClinicState.initial());

  final Dio _dio = DioClient.instance;
  Future<void> fetchClinic(
    String? title,
    String? doctorName,
    String? specialization,
    String? region,
    String? city,
  ) async {
    try {
      emit(const ClinicState.loading());
      final Map<String, dynamic> queryParameters = {};
      if (title != null && title.isNotEmpty) {
        queryParameters['title'] = title;
      }
      if (doctorName != null && doctorName.isNotEmpty) {
        queryParameters['doctorName'] = doctorName;
      }
      if (specialization != null && specialization.isNotEmpty) {
        queryParameters['specialization'] = specialization;
      }
      if (region != null && region.isNotEmpty) {
        queryParameters['region'] = region;
      }
      if (city != null && city.isNotEmpty) {
        queryParameters['city'] = city;
      }
      final response = await _dio.get(
        '/clinics',
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data as List;
        final List<ClinicModel> clinics = responseData
            .map((json) => ClinicModel.fromJson(json as Map<String, dynamic>))
            .toList();
        emit(ClinicState.loaded(clinics));
      } else {
        emit(const ClinicState.error('Failed to fetch clinic data'));
      }
    } on DioException catch (e) {
      // You can add more specific error handling if needed.
      final errorMessage =
          e.response?.data['message'] ?? 'An unknown network error occurred';
      emit(ClinicState.error(errorMessage));
    } catch (e) {
      emit(ClinicState.error('Unexpected error: ${e.toString()}'));
    }
  }

  void clearClinic() {
    emit(const ClinicState.initial());
  }
}
