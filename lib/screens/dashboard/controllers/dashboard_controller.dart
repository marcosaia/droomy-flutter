import 'package:droomy/screens/base/view_state.dart';
import 'package:droomy/screens/dashboard/controllers/dashboard_state.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/project_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardControllerProvider =
    StateNotifierProvider.autoDispose<DashboardController, DashboardState>(
        (ref) {
  return DashboardController(DashboardState.defaultState(),
      ref.read(authProvider), ref.read(projectRepositoryProvider));
});

class DashboardController extends StateNotifier<DashboardState> {
  // Dependencies
  final AuthService _authService;
  final ProjectRepository _projectRepository;

  DashboardController(super.state, this._authService, this._projectRepository) {
    state = state.copyWith(currentUser: _authService.currentUser);
  }

  Future<void> fetchUserProjects() async {
    state = state.copyWith(
        viewState: const ViewStateLoading(), isProjectsLoading: true);

    final projects = await _projectRepository.getAll();
    projects.sort((pr1, pr2) => pr1.createdAt.isAfter(pr2.createdAt) ? -1 : 1);
    state = state.copyWith(
        projects: projects,
        viewState: const ViewStateLoaded(),
        isProjectsLoading: false);
  }
}
