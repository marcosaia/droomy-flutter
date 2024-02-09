import 'package:droomy/screens/dashboard/controllers/dashboard_state.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:riverpod/riverpod.dart';

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  final authService = ref.read(authServiceProvider);
  return DashboardController(DashboardState.defaultState(), authService);
});

class DashboardController extends StateNotifier<DashboardState> {
  final AuthService _authService;
  DashboardController(super.state, this._authService) {
    state = state.copyWith(currentUser: _authService.currentUser);
  }
}
