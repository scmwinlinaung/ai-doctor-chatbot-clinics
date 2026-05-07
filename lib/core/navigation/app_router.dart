import 'package:clinics/core/navigation/auth_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/features/auth/views/forget_password_screen.dart';
import 'package:clinics/features/auth/views/login_screen.dart';
import 'package:clinics/features/home/views/splash_screen.dart';
import 'package:clinics/features/redemption/views/redemption_scanner_screen.dart';
import 'package:clinics/features/reports/cubit/report_cubit.dart';
import 'package:clinics/features/reports/views/clinic_report_screen.dart';
import 'package:clinics/features/subscription/views/subscription_screen.dart';
import 'package:clinics/core/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      // GoRoute(
      //   path: AppRoutes.bookingListing, // Use the static constant
      //   builder: (context, state) => const BookingListingScreenProvider(),
      // ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
