import 'package:droomy/models/project.dart';
import 'package:droomy/models/user.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_overview_state.freezed.dart';

@freezed
class DashboardOverviewState with _$DashboardOverviewState {
  const factory DashboardOverviewState({
    @Default([]) List<Project> projects,
    @Default(false) bool isProjectsLoading,
    User? currentUser,
    required ViewState viewState,
  }) = _DashboardOverviewState;

  static DashboardOverviewState defaultState() =>
      const DashboardOverviewState(viewState: ViewStateLoaded());
}
