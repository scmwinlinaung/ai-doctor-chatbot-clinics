import 'dart:io';

import 'package:clinics/features/booking/cubit/booking_cubit.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:clinics/features/home/cubit/city_cubit.dart';
import 'package:clinics/features/home/cubit/language_cubit.dart';
import 'package:clinics/features/home/cubit/region_cubit.dart';
import 'package:clinics/core/services/notification_service.dart';
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
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHiveData();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize notifications without requesting permission yet
  await _initNotifications();
  await configureDependencies();
  runApp(const HealthGuideApp());
}

/// Initialize Firebase and push notifications
/// Note: We don't request permission here to avoid iOS showing dialog too early
Future<void> _initNotifications() async {
  try {
    debugPrint('========================================');
    debugPrint('_initNotifications() called');
    debugPrint('========================================');
    // Initialize without requesting permission - we'll request it later after UI shows
    await NotificationService().initialize(requestPermission: true);
    debugPrint(
        'Notification service initialized successfully');
  } catch (e, stackTrace) {
    // Errors are already handled in NotificationService, so this is just for logging
    debugPrint('========================================');
    debugPrint('Note: FCM initialization had issues (this is OK on emulators): $e');
    debugPrint('App will continue to work with local notifications');
    debugPrint('========================================');
  }
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
