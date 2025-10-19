import 'package:clinics/features/home/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/auth/cubit/auth_cubit.dart';
import 'package:clinics/features/auth/cubit/user_cubit.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:clinics/features/theme/cubit/theme_cubit.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  @override
  void initState() {
    super.initState();
    fetchUser();
    // Fetch user data when the screen loads
  }

  Future<void> fetchUser() async {
    final TokenStorageService tokenStorageService = TokenStorageService();
    final userId = await tokenStorageService.getUserId();
    if (mounted) {
      context.read<UserCubit>().fetchUser(userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: GradientBackground(
        child: AnimationLimiter(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                _buildUserInfoSection(context),
                const SizedBox(height: 24),
                _buildThemeSection(context),
                const SizedBox(height: 24),
                _buildLanguageSection(context),
                const SizedBox(height: 24),
                _buildAppInfoSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your account settings',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            height: 0.2,
          ),
          const SizedBox(height: 16),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: LoadingWidget(),
                  ),
                );
              } else if (state is UserLoaded) {
                final user = state.user;
                return Column(
                  children: [
                    _buildInfoRow('Username', user.username),
                    _buildInfoRow('Phone Number', user.phoneno),
                    _buildInfoRow('Role', user.role.toUpperCase()),
                    _buildInfoRow(
                      'Member Since',
                      _formatDate(user.createdAt ?? DateTime.now()),
                    ),
                  ],
                );
              } else if (state is UserError) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.error,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Failed to load user data',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.message,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          context.read<UserCubit>().fetchUser(
                                '68d017f2239675addec4af93',
                              );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('No user data available'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // OVERFLOW FIX APPLIED HERE
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(width: 16), // Added for spacing
          Flexible(
            // Wrapped with Flexible to prevent overflow
            child: Text(
              value,
              textAlign: TextAlign.end, // Aligned text to the end
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthCubit>().logout();
                context.go('/');
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.palette_outlined,
                  color: Colors.purple,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Choose your preferred theme',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            height: 0.2,
          ),
          const SizedBox(height: 16),
          BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              final isDarkMode = theme.brightness == Brightness.dark;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.titleMedium?.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    activeColor: AppColors.primaryColor,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.language_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select your preferred language',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            height: 0.2,
          ),
          const SizedBox(height: 16),
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return Column(
                children: [
                  _buildLanguageOption(
                    context,
                    'English',
                    'en',
                    state.currentLanguage == 'en',
                  ),
                  const SizedBox(height: 12),
                  _buildLanguageOption(
                    context,
                    'မြန်မာ',
                    'mm',
                    state.currentLanguage == 'mm',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ANIMATION ADDED HERE
  Widget _buildLanguageOption(
    BuildContext context,
    String label,
    String value,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<LanguageCubit>().setLanguage(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.titleMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).primaryColor.withOpacity(0.3),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.orange,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'About this application',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            height: 0.2,
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Version', '1.0.0'),
          _buildInfoRow('Build', '2024.01.01'),
          _buildInfoRow('Developer', 'Health Guide Team'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
