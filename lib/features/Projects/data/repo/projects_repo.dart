import 'package:dartz/dartz.dart';
import 'package:technical_assessment_task/core/errors/failure.dart';
import 'package:technical_assessment_task/features/Projects/data/model/project_model.dart';
import 'package:technical_assessment_task/features/Projects/data/model/task_model.dart';

abstract class ProjectsRepo {
  Future<Either<Failure, List<ProjectModel>>> getProjects({required String token});

  Future<Either<Failure, List<TaskModel>>> getTasks({
    required String token,
    required String projectId,
  });

  Future<Either<Failure, TaskModel>> addTask({
    required String token,
    required String projectId,
    required String title,
    required String priority,
  });

  Future<Either<Failure, TaskModel>> updateTaskStatus({
    required String token,
    required String taskId,
    required String status,
  });
}
