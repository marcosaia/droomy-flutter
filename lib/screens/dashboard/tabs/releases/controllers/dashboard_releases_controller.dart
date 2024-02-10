import 'package:droomy/data/models/project_state.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:droomy/screens/dashboard/tabs/releases/controllers/dashboard_releases_state.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/project_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardReleasesControllerProvider =
    StateNotifierProvider<DashboardReleasesController, DashboardReleasesState>(
        (ref) {
  final projectRepository = ref.read(projectRepositoryProvider);
  return DashboardReleasesController(
      DashboardReleasesState.defaultState(), projectRepository);
});

class DashboardReleasesController
    extends StateNotifier<DashboardReleasesState> {
  final ProjectRepository _projectRepository;
  DashboardReleasesController(super.state, this._projectRepository);

  Future<void> fetchReleases() async {
    state = state.copyWith(
        viewState: const ViewStateLoading(), isProjectsLoading: true);

    final projects = (await _projectRepository.getAll())
        .where((project) =>
            project.state == ProjectState.readyForDistribution ||
            project.state == ProjectState.distributed)
        .toList();

    projects.sort((pr1, pr2) => pr1.createdAt.isAfter(pr2.createdAt) ? -1 : 1);

    state = state.copyWith(
        isProjectsLoading: false,
        releases: projects,
        viewState: const ViewStateLoaded());
  }
}
