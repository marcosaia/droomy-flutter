import 'package:droomy/models/user.dart';
import 'package:droomy/screens/base/view_state.dart';
import 'package:droomy/screens/login/controllers/login_controller.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthServiceProvider extends AuthService {
  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return null;
  }

  @override
  Future<User?> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));
    currentUser = User(
        displayName: 'Mock User', uid: 'mock_user', email: '', photoUrl: '');
    return currentUser;
  }

  @override
  Future<bool> signOut() async {
    return true;
  }
}

void main() {
  test('LoginController valid google sign-in', () async {
    final container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(MockAuthServiceProvider()),
      ],
    );

    // Listening to controller so that it is not autodisposed
    container.listen(loginControllerProvider.notifier, (s1, s2) {});

    // Launch sign in with google
    final controller = container.read(loginControllerProvider.notifier);
    final signInFuture = controller.signInWithGoogle();

    // Check if state = loading
    expect(container.read(loginControllerProvider).viewState,
        const ViewStateLoading());

    // Wait for login to finish
    await signInFuture;

    // Check if state = loaded
    expect(container.read(loginControllerProvider).viewState,
        const ViewStateLoaded());

    // Check if loggedIn is true
    expect(container.read(loginControllerProvider).isLoggedIn, true);

    // Check if the user has been updated
    expect(container.read(authProvider).currentUser,
        isA<User>().having((u) => u.displayName, 'displayName', 'Mock User'));
  });
}
