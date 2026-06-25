import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment_task/core/widgets/responsive_center.dart';
import 'package:technical_assessment_task/features/Projects/presentation/manager/cubit/tasks_cubit.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/add_task_sheet.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/empty_state_view.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/error_view.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/task_tile.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;
  final String? projectTitle;
  const ProjectDetailsScreen({super.key, required this.projectId, this.projectTitle});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  String get _token => Hive.box('authBox').get('token') ?? '';

  @override
  void initState() {
    super.initState();
    context.read<TasksCubit>().loadTasks(token: _token, projectId: widget.projectId);
  }

  void _openAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => AddTaskSheet(
        onSubmit: (title, priority) => context.read<TasksCubit>().addTask(
              token: _token,
              projectId: widget.projectId,
              title: title,
              priority: priority,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'project-title-${widget.projectId}',
          child: Material(
            type: MaterialType.transparency,
            child: Text(widget.projectTitle ?? 'Project Details'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskSheet,
        child: const Icon(Icons.add),
      ),
      body: ResponsiveCenter(
        child: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            if (state is TasksLoading || state is TasksInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TasksError) {
              return ErrorView(
                message: state.errorMessage,
                onRetry: () => context
                    .read<TasksCubit>()
                    .loadTasks(token: _token, projectId: widget.projectId),
              );
            } else if (state is TasksEmpty) {
              return const EmptyStateView(
                message: 'No tasks yet.\nTap + to add the first one.',
                icon: Icons.checklist_outlined,
              );
            }

            final tasks = (state as TasksLoaded).tasks;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(
                  task: task,
                  onMarkDone: () =>
                      context.read<TasksCubit>().markTaskDone(token: _token, taskId: task.id),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
