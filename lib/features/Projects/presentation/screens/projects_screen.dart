import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';
import 'package:technical_assessment_task/core/utils/app_routers_strings.dart';
import 'package:technical_assessment_task/core/widgets/responsive_center.dart';
import 'package:technical_assessment_task/features/Projects/presentation/manager/cubit/projects_cubit.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/empty_state_view.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/error_view.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/project_card.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String get _token => Hive.box('authBox').get('token') ?? '';

  @override
  void initState() {
    super.initState();
    context.read<ProjectsCubit>().loadProjects(token: _token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRoutersStrings.profile),
          ),
        ],
      ),
      body: ResponsiveCenter(
        child: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is ProjectsError) {
              return ErrorView(
                message: state.errorMessage,
                onRetry: () => context.read<ProjectsCubit>().loadProjects(token: _token),
              );
            }

            final projects = state is ProjectsLoaded ? state.projects : [];

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => context.read<ProjectsCubit>().loadProjects(token: _token),
              child: projects.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 120),
                        EmptyStateView(
                          message: 'No projects yet.\nPull down to refresh.',
                          icon: Icons.folder_off_outlined,
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return ProjectCard(
                          project: project,
                          onTap: () =>
                              context.push('/projectDetails/${project.id}', extra: project.title),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
