import 'package:droomy/data/models/user.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    User? currentUser,
    required ViewState viewState,
  }) = _DashboardState;

  static DashboardState defaultState() =>
      const DashboardState(viewState: ViewStateLoaded());
}
