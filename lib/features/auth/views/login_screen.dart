import 'package:clinics/core/constant/auth_constant.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          print(
              'AuthState changed: $state at ${DateTime.now()}'); // Debug log with timestamp
          if (state is AuthAuthenticated) {
            print('✅ User authenticated, navigating to home');
            context.go('/');
          } else if (state is AuthUnauthenticated) {
            print('❌ Authentication failed: ${state.error}'); // Debug log
            // Only show snackbar if there's a non-empty error message
            if (state.error.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 4),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              });
            }
          } else if (state is AuthLoading) {
            print('⏳ Authentication loading...');
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
                          'Login to your health guide account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
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
                              final RegExp myanmarPhoneRegex =
                                  RegExp(r'^09\d{7,9}$');
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
                              child: Text(AuthConstant.termsAndCondition,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is AuthLoading ||
                                      !_isDisclaimerChecked
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        // Disable button immediately to prevent multiple clicks
                                        FocusScope.of(context).unfocus();
                                        context.read<AuthCubit>().login(
                                            usernameOrPhonenoCtrl.text,
                                            passwordCtrl.text);
                                      }
                                    },
                              child: state is AuthLoading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                          color: theme.colorScheme.onPrimary),
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
