import 'package:droomy/common/constants.dart';
import 'package:droomy/screens/login/controllers/login_controller.dart';
import 'package:droomy/screens/login/controllers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../dashboard/screens/dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginControllerProvider.notifier).tryAutoSignIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.watch(loginControllerProvider.notifier);

    return Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.03,
              child: Image.asset(
                'assets/cow.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            state.viewState.map(
              loaded: (_) {
                if (state.isLoggedIn) {
                  Future.microtask(() => _navigateToDashboard(context));
                  return Container();
                }

                return _getLoginWidget(context, state, controller, false);
              },
              error: (_) => _getLoginWidget(context, state, controller, true),
              loading: (_) => const Center(child: CircularProgressIndicator()),
            )
          ],
        ));
  }

  Widget _getLoginWidget(BuildContext context, LoginState state,
      LoginController controller, bool showError) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(Constants.paddingBig),
            child: Column(
              children: [
                Text(
                  "Welcome to Droomy!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: Constants.paddingBig),
                Text(
                  "“Ugly design, questionable usefulness and a cow in the background for no reason.”",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.color
                          ?.withAlpha(100)),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButton(Buttons.Google, padding: const EdgeInsets.all(8.0),
                    onPressed: () async {
                  controller.signInWithGoogle();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Utility navigation methods
  _navigateToDashboard(BuildContext context) async {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (Route<dynamic> route) => false);
  }
}
