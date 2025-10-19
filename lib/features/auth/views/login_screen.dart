import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/core/constant/auth_constant.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/auth/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameOrPhonenoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool _isDisclaimerChecked = false;

  @override
  void dispose() {
    usernameOrPhonenoCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/');
          } else if (state is AuthUnauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: GradientBackground(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Theme(
                  data: theme.copyWith(
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: theme.primaryColor,
                    ),
                    inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.white38,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Login to your clinics account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 48),
                        CustomTextField(
                          hintText: 'Phone Number or Username',
                          controller: usernameOrPhonenoCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required.';
                            }
                            if (value.startsWith('0')) {
                              final RegExp myanmarPhoneRegex = RegExp(
                                r'^09\d{7,9}$',
                              );
                              if (!myanmarPhoneRegex.hasMatch(value)) {
                                return 'Please enter a valid Myanmar phone number.';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hintText: 'Password',
                          obscureText: true,
                          controller: passwordCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                context.go(AppRoutes.forgetPassword),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _isDisclaimerChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isDisclaimerChecked = value!;
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: theme.primaryColor,
                            ),
                            Expanded(
                              child: Text(
                                AuthConstant.termsAndCondition,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(child: LoadingWidget());
                            }
                            return ElevatedButton(
                              onPressed: !_isDisclaimerChecked
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                              usernameOrPhonenoCtrl.text,
                                              passwordCtrl.text,
                                            );
                                      }
                                    },
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
