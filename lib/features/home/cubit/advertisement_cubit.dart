import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/home/models/advertisement_model.dart';
import 'package:injectable/injectable.dart';

part 'advertisement_state.dart';
part 'advertisement_cubit.freezed.dart';

@injectable
class AdvertisementCubit extends Cubit<AdvertisementState> {
  AdvertisementCubit() : super(const AdvertisementState.initial());

  Future<void> fetchAdvertisements() async {
    emit(const AdvertisementState.loading());
    try {
      final Response response = await DioClient.instance.get(
        ApiRoute.advertisement,
      );
      final dynamic data = response.data;

      final List<AdvertisementModel> categories = (data as List<dynamic>)
          .map(
            (item) => AdvertisementModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      emit(AdvertisementState.success(categories));
    } catch (error) {
      emit(AdvertisementState.failure(error.toString()));
    }
  }
}
