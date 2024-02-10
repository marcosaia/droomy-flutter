import 'package:droomy/data/models/project_state.dart';
import 'package:droomy/screens/dashboard/controllers/dashboard_state.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/project_repository_provider.dart';
import 'package:riverpod/riverpod.dart';

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  final authService = ref.read(authServiceProvider);
  final projectRepository = ref.read(projectRepositoryProvider);
  return DashboardController(
      DashboardState.defaultState(), authService, projectRepository);
});

class DashboardController extends StateNotifier<DashboardState> {
  final AuthService _authService;
  final ProjectRepository _projectRepository;
  DashboardController(super.state, this._authService, this._projectRepository) {
    state = state.copyWith(
      currentUser: _authService.currentUser,
    );
  }

  Future<void> fetchData() async {
    final projects = await _projectRepository.getAll();

    state = state.copyWith(
        numOfPendingReleases: projects
            .where((proj) => proj.state == ProjectState.readyForDistribution)
            .length);
  }
}
