import 'package:droomy/view/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'firebase_options.dart';
import 'service/authentication/auth_service_provider.dart';
import 'view/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: DroomyApp(),
    ),
  );
}

class DroomyApp extends ConsumerWidget {
  const DroomyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final isUserLoggedIn = auth.currentUser != null;

    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.highContrastDark(),
      ),
      themeMode: ThemeMode.dark,
      home: isUserLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
