import 'package:clinics/core/navigation/auth_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/features/auth/views/forget_password_screen.dart';
import 'package:clinics/features/auth/views/login_screen.dart';
import 'package:clinics/features/home/views/splash_screen.dart';
import 'package:clinics/features/subscription/views/subscription_screen.dart';

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
