// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clinics/features/auth/cubit/auth_cubit.dart' as _i304;
import 'package:clinics/features/auth/cubit/user_cubit.dart' as _i142;
import 'package:clinics/features/auth/services/token_storage_service.dart'
    as _i225;
import 'package:clinics/features/booking/cubit/booking_cubit.dart' as _i999;
import 'package:clinics/features/booking/cubit/clinic_cubit.dart' as _i983;
import 'package:clinics/features/booking/service/booking_service.dart' as _i11;
import 'package:clinics/features/booking/service/clinic_service.dart' as _i753;
import 'package:clinics/features/home/cubit/advertisement_cubit.dart' as _i745;
import 'package:clinics/features/home/cubit/city_cubit.dart' as _i1045;
import 'package:clinics/features/home/cubit/language_cubit.dart' as _i267;
import 'package:clinics/features/home/cubit/region_cubit.dart' as _i548;
import 'package:clinics/features/theme/cubit/theme_cubit.dart' as _i532;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i548.RegionCubit>(() => _i548.RegionCubit());
    gh.factory<_i745.AdvertisementCubit>(() => _i745.AdvertisementCubit());
    gh.factory<_i267.LanguageCubit>(() => _i267.LanguageCubit());
    gh.factory<_i1045.CityCubit>(() => _i1045.CityCubit());
    gh.factory<_i142.UserCubit>(() => _i142.UserCubit());
    gh.factory<_i225.TokenStorageService>(() => _i225.TokenStorageService());
    gh.factory<_i532.ThemeCubit>(() => _i532.ThemeCubit());
    gh.factory<_i11.BookingService>(() => _i11.BookingService());
    gh.factory<_i753.ClinicService>(() => _i753.ClinicService());
    gh.factory<_i999.BookingCubit>(
        () => _i999.BookingCubit(gh<_i11.BookingService>()));
    gh.factory<_i304.AuthCubit>(
        () => _i304.AuthCubit(gh<_i225.TokenStorageService>()));
    gh.factory<_i983.ClinicCubit>(
        () => _i983.ClinicCubit(gh<_i753.ClinicService>()));
    return this;
  }
}
