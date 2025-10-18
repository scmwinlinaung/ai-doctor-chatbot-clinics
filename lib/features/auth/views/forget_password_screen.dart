import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/auth/cubit/auth_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final phonenoCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    phonenoCtrl.dispose();
    newPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: CustomBackButton(
                  iconColor: Theme.of(context).primaryColor,
                  callback: () => context.go(AppRoutes.login),
                ),
              ),
              Expanded(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is Success) {
                      context.go(AppRoutes.login);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password changed successfully.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (state is Failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Theme(
                          data: theme.copyWith(
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: theme.primaryColor,
                            ),
                            inputDecorationTheme: theme.inputDecorationTheme
                                .copyWith(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
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
                                  'Forgot Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Enter your details to reset your password.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                CustomTextField(
                                  hintText: 'Phone Number (09xxxxxxxx)',
                                  controller: phonenoCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Phone number is required.';
                                    }
                                    final RegExp myanmarPhoneRegex = RegExp(
                                      r'^09\d{7,9}$',
                                    );
                                    if (!myanmarPhoneRegex.hasMatch(value)) {
                                      return 'Please enter a valid Myanmar phone number.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'New Password',
                                  obscureText: true,
                                  controller: newPasswordCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'New password is required.';
                                    }
                                    if (value.length < 4) {
                                      return 'Password must be at least 4 characters.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 48),
                                if (state is AuthLoading)
                                  const Center(child: LoadingWidget())
                                else
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<AuthCubit>()
                                            .changePassword(
                                              phonenoCtrl.text,
                                              newPasswordCtrl.text,
                                            );
                                        if (state is Success) {
                                          context.push(AppRoutes.login);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Submit',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
