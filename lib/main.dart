import 'package:droomy/common/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'firebase_options.dart';
import 'services/authentication/auth_service_provider.dart';
import 'screens/dashboard/screens/dashboard_screen.dart';
import 'screens/login/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run App in Provider Scope (for Riverpod)
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
    final auth = ref.watch(authServiceProvider);
    final isUserLoggedIn = auth.currentUser != null;
    final isDarkMode = ref.watch(isDarkModeProvider);

    print("Should rebuild Widget because isDarkMode was updated");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: isUserLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
