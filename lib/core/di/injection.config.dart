// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:clinics/features/auth/cubit/auth_cubit.dart' as _i157;
import 'package:clinics/features/auth/cubit/user_cubit.dart' as _i344;
import 'package:clinics/features/auth/services/token_storage_service.dart'
    as _i458;
import 'package:clinics/features/booking/cubit/book_cubit.dart' as _i546;
import 'package:clinics/features/booking/cubit/city_cubit.dart' as _i955;
import 'package:clinics/features/booking/cubit/clinic_cubit.dart' as _i810;
import 'package:clinics/features/booking/cubit/region_cubit.dart' as _i46;
import 'package:clinics/features/chatbot/cubit/category_cubit.dart' as _i261;
import 'package:clinics/features/chatbot/cubit/chatbot_cubit.dart' as _i812;
import 'package:clinics/features/chatbot/cubit/language_cubit.dart' as _i256;
import 'package:clinics/features/home/cubit/advertisement_cubit.dart' as _i363;
import 'package:clinics/features/theme/cubit/theme_cubit.dart' as _i806;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i363.AdvertisementCubit>(() => _i363.AdvertisementCubit());
    gh.factory<_i344.UserCubit>(() => _i344.UserCubit());
    gh.factory<_i458.TokenStorageService>(() => _i458.TokenStorageService());
    gh.factory<_i261.CategoryCubit>(() => _i261.CategoryCubit());
    gh.factory<_i812.ChatbotCubit>(() => _i812.ChatbotCubit());
    gh.factory<_i256.LanguageCubit>(() => _i256.LanguageCubit());
    gh.factory<_i46.RegionCubit>(() => _i46.RegionCubit());
    gh.factory<_i955.CityCubit>(() => _i955.CityCubit());
    gh.factory<_i546.BookCubit>(() => _i546.BookCubit());
    gh.factory<_i810.ClinicCubit>(() => _i810.ClinicCubit());
    gh.factory<_i806.ThemeCubit>(() => _i806.ThemeCubit());
    gh.factory<_i157.AuthCubit>(
      () => _i157.AuthCubit(gh<_i458.TokenStorageService>()),
    );
    return this;
  }
}
