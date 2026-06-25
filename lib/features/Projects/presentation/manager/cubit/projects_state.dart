part of 'projects_cubit.dart';

abstract class ProjectsState {}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsEmpty extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectModel> projects;
  ProjectsLoaded(this.projects);
}

class ProjectsError extends ProjectsState {
  final String errorMessage;
  ProjectsError(this.errorMessage);
}
