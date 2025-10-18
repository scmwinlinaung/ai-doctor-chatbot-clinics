import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/core/constant/auth_constant.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/custom_dropdown_button_form_field.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/custom_text_field.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/auth/cubit/auth_cubit.dart';
import 'package:clinics/features/booking/cubit/city_cubit.dart';
import 'package:clinics/features/booking/cubit/region_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final phonenoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final regionCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  bool _isDisclaimerChecked = false;
  String? _selectedRegion;
  String? _selectedCity;

  @override
  void dispose() {
    usernameCtrl.dispose();
    phonenoCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    regionCtrl.dispose();
    cityCtrl.dispose();
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
                    if (state is AuthAuthenticated) {
                      context.go('/');
                    } else if (state is AuthUnauthenticated) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      });
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
                                  'Create Account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Start your journey with a new account.',
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
                                  hintText: 'Username',
                                  controller: usernameCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username is required.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<RegionCubit, RegionState>(
                                  builder: (context, state) {
                                    final cityItems = state.when(
                                      initial: () => <DropdownMenuItem<String>>[
                                        const DropdownMenuItem(
                                          value: "All Regions",
                                          child: Text("All Regions"),
                                        ),
                                      ],
                                      loading: () =>
                                          <DropdownMenuItem<String>>[],
                                      error: (message) =>
                                          <DropdownMenuItem<String>>[],
                                      loaded: (cities) {
                                        if (cities.isEmpty)
                                          return <DropdownMenuItem<String>>[];
                                        final cityNames = [
                                          "All Regions",
                                          ...cities.map((c) => c.name),
                                        ];
                                        return cityNames
                                            .map(
                                              (name) => DropdownMenuItem(
                                                value: name,
                                                child: Text(name),
                                              ),
                                            )
                                            .toList();
                                      },
                                    );

                                    return CustomDropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Region is required.';
                                        }
                                        return null;
                                      },
                                      labelText: 'Region',
                                      icon: Icons.location_city_rounded,
                                      value: _selectedRegion,
                                      items: cityItems,
                                      onChanged: (value) {
                                        setState(() => _selectedRegion = value);
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<CityCubit, CityState>(
                                  builder: (context, state) {
                                    final cityItems = state.when(
                                      initial: () => <DropdownMenuItem<String>>[
                                        const DropdownMenuItem(
                                          value: "All Cities",
                                          child: Text("All Cities"),
                                        ),
                                      ],
                                      loading: () =>
                                          <DropdownMenuItem<String>>[],
                                      error: (message) =>
                                          <DropdownMenuItem<String>>[],
                                      loaded: (cities) {
                                        if (cities.isEmpty)
                                          return <DropdownMenuItem<String>>[];
                                        final cityNames = [
                                          "All Cities",
                                          ...cities.map((c) => c.name),
                                        ];
                                        return cityNames
                                            .map(
                                              (name) => DropdownMenuItem(
                                                value: name,
                                                child: Text(name),
                                              ),
                                            )
                                            .toList();
                                      },
                                    );

                                    return CustomDropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'City is required.';
                                        }
                                        return null;
                                      },
                                      labelText: 'City',
                                      icon: Icons.location_city_rounded,
                                      value: _selectedCity,
                                      items: cityItems,
                                      onChanged: (value) {
                                        setState(() => _selectedCity = value);
                                      },
                                    );
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
                                    if (value.length < 4) {
                                      return 'Password must be at least 4 characters.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'Confirm Password',
                                  obscureText: true,
                                  controller: confirmPasswordCtrl,
                                  validator: (value) {
                                    if (value != passwordCtrl.text) {
                                      return 'Passwords do not match.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 24),
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12.0,
                                        ),
                                        child: Text(
                                          AuthConstant.termsAndCondition,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                if (state is AuthLoading)
                                  const Center(child: LoadingWidget())
                                else
                                  ElevatedButton(
                                    onPressed: !_isDisclaimerChecked
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<AuthCubit>().signUp(
                                                phonenoCtrl.text,
                                                usernameCtrl.text,
                                                passwordCtrl.text,
                                                _selectedRegion!,
                                                _selectedCity!,
                                              );
                                            }
                                          },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          context.go(AppRoutes.login),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
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
