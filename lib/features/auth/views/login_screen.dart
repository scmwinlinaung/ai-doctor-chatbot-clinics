import 'package:clinics/core/constant/auth_constant.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/custom_button.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
import 'package:clinics/core/widgets/glassmorphism.dart';
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
          if (state is AuthAuthenticated) {
            context.go('/');
          } else if (state is AuthUnauthenticated) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        child: GradientBackground(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Responsiveness: Limit card width on larger screens
                    final maxWidth =
                        constraints.maxWidth > 600 ? 500.0 : constraints.maxWidth;

                    return SizedBox(
                      width: maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo Section
                          Hero(
                            tag: 'app_logo',
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 120,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Login Card with Glassmorphism
                          Glassmorphism(
                            blur: 15,
                            opacity: 0.15,
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Welcome Back',
                                      style: theme.textTheme.headlineMedium
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sign in to continue your clinic management',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.white70,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 40),

                                    // Username/Phone Input
                                    CustomTextField(
                                      hintText: 'Phone Number',
                                      controller: usernameOrPhonenoCtrl,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: theme.primaryColor,
                                      ),
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
                                    const SizedBox(height: 20),

                                    // Password Input
                                    CustomTextField(
                                      hintText: 'Password',
                                      obscureText: true,
                                      controller: passwordCtrl,
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: theme.primaryColor,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password is required.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    // Disclaimer Section
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                            value: _isDisclaimerChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isDisclaimerChecked = value!;
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            activeColor: theme.primaryColor,
                                            side: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isDisclaimerChecked =
                                                    !_isDisclaimerChecked;
                                              });
                                            },
                                            child: Text(
                                              AuthConstant.termsAndCondition,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),

                                    // Login Button
                                    BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        return CustomButton(
                                          text: 'LOGIN',
                                          isLoading: state is AuthLoading,
                                          onPressed: !_isDisclaimerChecked
                                              ? () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Please accept the terms and conditions.',
                                                      ),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                              : () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    context.read<AuthCubit>().login(
                                                          usernameOrPhonenoCtrl
                                                              .text,
                                                          passwordCtrl.text,
                                                        );
                                                  }
                                                },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
