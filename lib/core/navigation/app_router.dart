import 'package:clinics/core/navigation/auth_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/features/auth/views/forget_password_screen.dart';
import 'package:clinics/features/auth/views/login_screen.dart';
import 'package:clinics/features/home/views/splash_screen.dart';
import 'package:clinics/features/redemption/views/redemption_scanner_screen.dart';
import 'package:clinics/features/reports/cubit/report_cubit.dart';
import 'package:clinics/features/reports/cubit/booking_report_cubit.dart';
import 'package:clinics/features/reports/views/booking_report_screen.dart';
import 'package:clinics/features/reports/views/clinic_report_screen.dart';
import 'package:clinics/features/subscription/views/subscription_screen.dart';
import 'package:clinics/features/booking/views/doctor_list_screen.dart';
import 'package:clinics/features/booking/cubit/doctor_notification_cubit.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:clinics/core/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash', // Use the main navigation as initial route
    routes: [
      GoRoute(
        path: '/', // Auth wrapper that checks token
        builder: (context, state) => const AuthWrapper(),
      ),
      GoRoute(
        path: '/splash', // Auth wrapper that checks token
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login, // Use the static constant
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.subscription, // Use the static constant
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: AppRoutes.redemptionScanner, // Redemption scanner route
        builder: (context, state) => const RedemptionScannerScreen(),
      ),
      GoRoute(
        path: AppRoutes.clinicReport,
        builder: (context, state) {
          final clinicId = state.uri.queryParameters['clinicId'] ?? '';
          return BlocProvider(
            create: (context) => getIt<ReportCubit>(),
            child: ClinicReportScreen(clinicId: clinicId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.bookingReport,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<BookingReportCubit>(),
            child: const BookingReportScreen(),
          );
        },
      ),
      // GoRoute(
      //   path: AppRoutes.bookingListing, // Use the static constant
      //   builder: (context, state) => const BookingListingScreenProvider(),
      // ),
      GoRoute(
        path: AppRoutes.doctorList,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<ClinicCubit>()),
              BlocProvider(create: (context) => getIt<DoctorNotificationCubit>()),
            ],
            child: const DoctorListScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
