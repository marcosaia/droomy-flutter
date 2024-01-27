import 'package:droomy/screens/base/view_state.dart';
import 'package:droomy/screens/login/controllers/login_state.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
  return LoginController(LoginState.defaultState(), ref.read(authProvider));
});

class LoginController extends StateNotifier<LoginState> {
  final AuthService _authService;

  LoginController(super.state, this._authService);

  Future<void> signInWithGoogle() async {
    state = state.copyWith(viewState: const ViewStateLoading());
    final user = await _authService.signInWithGoogle();

    if (user == null) {
      state = state.copyWith(viewState: const ViewState.error());
      return;
    }

    state =
        state.copyWith(isLoggedIn: true, viewState: const ViewStateLoaded());
  }
}
