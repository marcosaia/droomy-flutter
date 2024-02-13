import 'package:droomy/common/date_utils.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:droomy/screens/release/controllers/release_detail_state.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/project_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final releaseDetailControllerProvider = StateNotifierProvider.family<
    ReleaseDetailController, ReleaseDetailState, Project>((ref, project) {
  final projectRepository = ref.read(projectRepositoryProvider);
  return ReleaseDetailController(
      ReleaseDetailState.defaultState(), project, projectRepository);
});

class ReleaseDetailController extends StateNotifier<ReleaseDetailState> {
  static const kRecommendedWaitingDays = 21;

  final Project _project;
  final ProjectRepository _projectRepository;

  Project? _lastConflict;

  ReleaseDetailController(super.state, this._project, this._projectRepository) {
    _computeBestReleaseDate();
  }

  Future<void> scheduleRelease() async {
    final releaseDate = state.bestReleaseDate;
    if (releaseDate == null) {
      throw Exception("Can't schedule release because bestReleaseDate is null");
    }

    _project.plannedReleaseDate = releaseDate;

    await _projectRepository.update(_project);

    state = state.copyWith(isScheduled: true);
  }

  Future<void> _computeBestReleaseDate() async {
    state = state.copyWith(viewState: const ViewStateLoading());

    final projects = await _projectRepository.getAll();
    final bestDate = _findBestDate(
        projects, DateTime.now().closestFridayAfter(kRecommendedWaitingDays));

    state = state.copyWith(
        viewState: const ViewStateLoaded(),
        bestReleaseDate: bestDate,
        releaseDateExplanation: _lastConflict != null
            ? "One week after your scheduled release for '${_lastConflict!.title}'"
            : null);
  }

  DateTime _findBestDate(List<Project> projects, DateTime startDate) {
    final conflicts = projects.where((project) =>
        project.plannedReleaseDate != null &&
        project.plannedReleaseDate!.day == startDate.day &&
        project.plannedReleaseDate!.month == startDate.month &&
        project.plannedReleaseDate!.year == startDate.year);

    if (conflicts.isNotEmpty) {
      final furthest = conflicts.reduce((a, b) =>
          a.plannedReleaseDate!.isAfter(b.plannedReleaseDate!) ? a : b);
      _lastConflict = furthest;
      return _findBestDate(
          projects, furthest.plannedReleaseDate!.add(const Duration(days: 7)));
    }

    return startDate;
  }
}
