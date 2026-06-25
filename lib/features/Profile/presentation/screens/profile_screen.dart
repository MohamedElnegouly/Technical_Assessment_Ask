import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment_task/core/theme/theme_cubit.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';
import 'package:technical_assessment_task/core/widgets/responsive_center.dart';
import 'package:technical_assessment_task/features/Authentication/data/model/auth_model.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<AuthModel>('userBox');
    final user = box.get('user')?.user;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ResponsiveCenter(
        maxWidth: 480,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 3),
              ),
              child: CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.primary,
                child: Text(
                  (user?.name.isNotEmpty ?? false) ? user!.name[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(user?.name ?? 'Unknown user', style: textTheme.titleLarge),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(user?.email ?? '', style: textTheme.bodySmall),
          ),
          const SizedBox(height: 32),
          Text(
            'PREFERENCES',
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: const Text('Dark mode'),
                  secondary: Icon(
                    themeMode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: AppColors.primary,
                  ),
                  value: themeMode == ThemeMode.dark,
                  onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent, width: 1.4),
            ),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Logout'),
            onPressed: () => context.read<AuthCubit>().logout(context),
          ),
          ],
        ),
      ),
    );
  }
}
