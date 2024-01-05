import 'dart:convert';

import 'package:droomy/view/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';

import 'common/constants.dart';
import 'firebase_options.dart';
import 'service/authentication/auth_service_provider.dart';
import 'view/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load theme from JSON
  var themeStr = await rootBundle.loadString("assets/purple_theme.json");
  var themeData = jsonDecode(themeStr);
  var theme = ThemeDecoder.decodeThemeData(themeData);
  runApp(
    ProviderScope(
      child: DroomyApp(theme: theme),
    ),
  );
}

class DroomyApp extends ConsumerWidget {
  final ThemeData? theme;

  const DroomyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final isUserLoggedIn = auth.currentUser != null;

    return MaterialApp(
      title: Constants.appName,
      theme: theme ?? getDefaultThemeData(),
      darkTheme: getDefaultThemeData(),
      themeMode: ThemeMode.dark,
      home: isUserLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }

  ThemeData getDefaultThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme.highContrastDark(),
      useMaterial3: true,
    );
  }
}
