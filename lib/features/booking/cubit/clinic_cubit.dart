import 'package:clinics/features/booking/model/clinic_model.dart';
import 'package:clinics/features/booking/service/clinic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'clinic_state.dart';
part 'clinic_cubit.freezed.dart';

@injectable
class ClinicCubit extends Cubit<ClinicState> {
  final ClinicService _clinicService;

  ClinicCubit(this._clinicService) : super(const ClinicState.initial());
  Future<void> getAClinicByID(String id) async {
    try {
      emit(const ClinicState.loading());
      final ClinicModel clinic = await _clinicService.getAClinicByID(id);
      emit(ClinicState.loaded(clinic));
    } catch (e) {
      emit(ClinicState.error('Unexpected error: ${e.toString()}'));
    }
  }
}
