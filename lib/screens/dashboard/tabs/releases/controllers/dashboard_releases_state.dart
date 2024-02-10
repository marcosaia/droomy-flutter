import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_releases_state.freezed.dart';

@freezed
class DashboardReleasesState with _$DashboardReleasesState {
  const factory DashboardReleasesState({
    @Default([]) List<Project> releases,
    @Default(false) bool isProjectsLoading,
    required ViewState viewState,
  }) = _DashboardReleasesState;

  static DashboardReleasesState defaultState() =>
      const DashboardReleasesState(viewState: ViewStateLoaded());
}
