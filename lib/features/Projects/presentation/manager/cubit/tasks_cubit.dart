import 'package:bloc/bloc.dart';
import 'package:technical_assessment_task/features/Projects/data/model/task_model.dart';
import 'package:technical_assessment_task/features/Projects/data/repo/projects_repo.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final ProjectsRepo projectsRepo;
  TasksCubit(this.projectsRepo) : super(TasksInitial());

  List<TaskModel> _tasks = [];

  Future<void> loadTasks({required String token, required String projectId}) async {
    emit(TasksLoading());
    final result = await projectsRepo.getTasks(token: token, projectId: projectId);
    result.fold(
      (failure) => emit(TasksError(failure.errMessage)),
      (tasks) {
        _tasks = tasks;
        emit(_tasks.isEmpty ? TasksEmpty() : TasksLoaded(List.of(_tasks)));
      },
    );
  }

  Future<void> markTaskDone({required String token, required String taskId}) async {
    final result = await projectsRepo.updateTaskStatus(
      token: token,
      taskId: taskId,
      status: 'Done',
    );
    result.fold(
      (failure) => emit(TasksError(failure.errMessage)),
      (updatedTask) {
        _tasks = _tasks.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
        emit(TasksLoaded(List.of(_tasks)));
      },
    );
  }

  Future<void> addTask({
    required String token,
    required String projectId,
    required String title,
    required String priority,
  }) async {
    final result = await projectsRepo.addTask(
      token: token,
      projectId: projectId,
      title: title,
      priority: priority,
    );
    result.fold(
      (failure) => emit(TasksError(failure.errMessage)),
      (newTask) {
        _tasks = [..._tasks, newTask];
        emit(TasksLoaded(List.of(_tasks)));
      },
    );
  }
}
