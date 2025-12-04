import 'dart:io';

import 'package:clinics/features/booking/cubit/booking_cubit.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:clinics/features/home/cubit/city_cubit.dart';
import 'package:clinics/features/home/cubit/language_cubit.dart';
import 'package:clinics/features/home/cubit/region_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:clinics/core/di/injection.dart';
import 'package:clinics/core/navigation/app_router.dart';
import 'package:clinics/features/theme/cubit/theme_cubit.dart';
import 'package:clinics/features/auth/cubit/user_cubit.dart';
import 'package:clinics/features/auth/cubit/auth_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHiveData();
  await configureDependencies();
  runApp(const HealthGuideApp());
}

Future<void> _initHiveData() async {
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
}

class HealthGuideApp extends StatelessWidget {
  const HealthGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ClinicCubit>()),
        BlocProvider(create: (context) => getIt<LanguageCubit>()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<UserCubit>()),
        BlocProvider(
          create: (context) => getIt<AuthCubit>()..checkAuthStatus(),
        ),
        BlocProvider<CityCubit>(
          create: (context) => GetIt.instance<CityCubit>()..fetchCities(),
        ),
        BlocProvider<RegionCubit>(
          create: (context) => GetIt.instance<RegionCubit>()..fetchRegions(),
        ),
        BlocProvider(create: (context) => GetIt.instance<BookingCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            title: 'Health Guide',
            theme: theme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
