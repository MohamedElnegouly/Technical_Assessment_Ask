import 'package:bloc/bloc.dart';
import 'package:technical_assessment_task/features/Projects/data/model/project_model.dart';
import 'package:technical_assessment_task/features/Projects/data/repo/projects_repo.dart';
part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  final ProjectsRepo projectsRepo;
  ProjectsCubit(this.projectsRepo) : super(ProjectsInitial());

  Future<void> loadProjects({required String token}) async {
    emit(ProjectsLoading());
    final result = await projectsRepo.getProjects(token: token);
    result.fold(
      (failure) => emit(ProjectsError(failure.errMessage)),
      (projects) => emit(projects.isEmpty ? ProjectsEmpty() : ProjectsLoaded(projects)),
    );
  }
}
