import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/di/injection.dart';
import 'package:clinics/core/navigation/app_routes.dart'; // Import the new routes file
import 'package:clinics/core/navigation/auth_wrapper.dart';
import 'package:clinics/features/auth/views/forget_password_screen.dart';
import 'package:clinics/features/auth/views/login_screen.dart';
import 'package:clinics/features/auth/views/signup_screen.dart';
import 'package:clinics/features/booking/models/clinic_model.dart';
import 'package:clinics/features/booking/views/clinic_detail_screen.dart';
import 'package:clinics/features/booking/views/clinic_list_screen.dart';
import 'package:clinics/features/chatbot/cubit/chatbot_cubit.dart';
import 'package:clinics/features/chatbot/models/category_model.dart';
import 'package:clinics/features/chatbot/models/subcategory_model.dart';
import 'package:clinics/features/chatbot/views/category_screen.dart';
import 'package:clinics/features/chatbot/views/chatbot_screen.dart';
import 'package:clinics/features/chatbot/views/question_screen.dart';
import 'package:clinics/features/chatbot/views/subcategory_screen.dart';
import 'package:clinics/features/home/views/splash_screen.dart';
import 'package:clinics/features/subscription/views/subscription_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash', // Use the main navigation as initial route
    routes: [
      GoRoute(
        path: '/splash', // Auth wrapper that checks token
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/', // Auth wrapper that checks token
        builder: (context, state) => const AuthWrapper(),
        routes: <RouteBase>[
          GoRoute(
            path: 'category', // Use the static constant
            builder: (context, state) => const CategoryScreen(),
          ),
          GoRoute(
            path: 'clinics', // Use the static constant
            builder: (context, state) => const ClinicListScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login, // Use the static constant
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup, // Use the static constant
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatbot, // Use the static constant
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ChatbotCubit>(),
          child: const ChatbotScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.subscription, // Use the static constant
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: AppRoutes.subcategories,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is Map<String, dynamic> &&
              extra['category'] is CategoryModel &&
              extra['subcategories'] is List<SubcategoryModel>) {
            final category = extra['category'] as CategoryModel;
            final subs = extra['subcategories'] as List<SubcategoryModel>;
            return SubcategoryScreen(category: category, subcategories: subs);
          }
          // Fallback: go back if data is missing/wrong to avoid crash
          return const CategoryScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.questions, // Use the static constant
        builder: (context, state) {
          final extra = state.extra;
          if (extra is Map<String, dynamic> &&
              extra['categoryId'] is String &&
              extra['subcategoryId'] is String &&
              extra['subcategoryName'] is String) {
            final categoryId = extra['categoryId'] as String;
            final subcategoryId = extra['subcategoryId'] as String;
            final subcategoryName = extra['subcategoryName'] as String;
            return QuestionScreen(
              categoryId: categoryId,
              subcategoryId: subcategoryId,
              subcategoryName: subcategoryName,
            );
          }
          // Fallback: go back if data is missing/wrong to avoid crash
          return const CategoryScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
