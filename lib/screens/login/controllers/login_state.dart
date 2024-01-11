import 'package:droomy/screens/base/view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default(false) bool isLoggedIn,
    required ViewState viewState,
  }) = _LoginState;

  static LoginState defaultState() =>
      LoginState(viewState: const ViewStateLoaded());
}
