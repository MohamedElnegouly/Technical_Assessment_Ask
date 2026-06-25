import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:technical_assessment_task/core/errors/failure.dart';
import 'package:technical_assessment_task/core/utils/Api_service.dart';
import 'package:technical_assessment_task/core/utils/cache_service.dart';
import 'package:technical_assessment_task/features/Projects/data/model/project_model.dart';
import 'package:technical_assessment_task/features/Projects/data/model/task_model.dart';
import 'projects_repo.dart';

class ProjectsRepoImpl implements ProjectsRepo {
  final ApiService apiService;
  final CacheService cacheService;
  ProjectsRepoImpl(this.apiService, this.cacheService);

  Map<String, dynamic> _asJsonMap(dynamic e) => Map<String, dynamic>.from(e as Map);

  @override
  Future<Either<Failure, List<ProjectModel>>> getProjects({required String token}) async {
    const cacheKey = 'projects';
    try {
      final response = await apiService.get(endPoint: 'projects', token: token);
      final List projects = response['projects'] ?? [];
      cacheService.saveList(cacheKey, projects);
      return right(projects.map((e) => ProjectModel.fromJson(_asJsonMap(e))).toList());
    } on DioException catch (e) {
      final cached = cacheService.getList(cacheKey);
      if (cached != null) {
        return right(cached.map((e) => ProjectModel.fromJson(_asJsonMap(e))).toList());
      }
      return left(ServerError.fromDioError(e));
    } catch (e) {
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getTasks({
    required String token,
    required String projectId,
  }) async {
    final cacheKey = 'tasks_$projectId';
    try {
      final response = await apiService.get(
        endPoint: 'projects/$projectId/tasks',
        token: token,
      );
      final List tasks = response['tasks'] ?? [];
      cacheService.saveList(cacheKey, tasks);
      return right(tasks.map((e) => TaskModel.fromJson(_asJsonMap(e))).toList());
    } on DioException catch (e) {
      final cached = cacheService.getList(cacheKey);
      if (cached != null) {
        return right(cached.map((e) => TaskModel.fromJson(_asJsonMap(e))).toList());
      }
      return left(ServerError.fromDioError(e));
    } catch (e) {
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> addTask({
    required String token,
    required String projectId,
    required String title,
    required String priority,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: 'projects/$projectId/tasks',
        token: token,
        body: {'title': title, 'priority': priority},
      );
      return right(TaskModel.fromJson(response['task']));
    } on DioException catch (e) {
      return left(ServerError.fromDioError(e));
    } catch (e) {
      return left(ServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTaskStatus({
    required String token,
    required String taskId,
    required String status,
  }) async {
    try {
      final response = await apiService.patch(
        endpoint: 'tasks/$taskId',
        token: token,
        body: {'status': status},
      );
      return right(TaskModel.fromJson(response['task']));
    } on DioException catch (e) {
      return left(ServerError.fromDioError(e));
    } catch (e) {
      return left(ServerError(e.toString()));
    }
  }
}
