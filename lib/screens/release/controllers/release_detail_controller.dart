import 'package:droomy/common/date_utils.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/release/controllers/release_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final releaseDetailControllerProvider = StateNotifierProvider.family<
    ReleaseDetailController, ReleaseDetailState, Project>((ref, project) {
  return ReleaseDetailController(ReleaseDetailState.defaultState(), project);
});

class ReleaseDetailController extends StateNotifier<ReleaseDetailState> {
  static const kRecommendedWaitingDays = 21;

  final Project _project;
  ReleaseDetailController(super.state, this._project) {
    _computeBestReleaseDate();
  }

  void _computeBestReleaseDate() {
    state = state.copyWith(
        bestReleaseDate:
            DateTime.now().closestFridayAfter(kRecommendedWaitingDays));
  }
}
