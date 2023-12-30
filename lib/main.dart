import 'package:droomy/service/firebase_authentication.dart';
import 'package:droomy/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/constants.dart';
import 'firebase_options.dart';
import 'model/user.dart';
import 'view/project_wizard/project_wizard_title_screen.dart';
import 'widget/progress_overview_card.dart';
import 'widget/user_circular_button.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
      home: isUserLoggedIn
          ? const MyHomePage(title: 'Overview')
          : const LoginScreen(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyHomePageState();
  }

  // @override
  // State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = ref.watch(authProvider).currentUser;
    // TODO: If currentUser is not available, show an error
    if (currentUser == null) {
      // Navigator.of(context).pop();
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: UserCircularButton(
              displayName: currentUser.displayName,
              imageUrl: currentUser.photoUrl,
              onPressed: () => {},
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Hello,\n${currentUser.displayName}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Spacer(),
                OutlinedButton(
                    onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TitleInputScreen()))
                        },
                    child: const Text("NEW PROJECT"))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            const ProgressOverviewCard(),
          ],
        ),
      ),
    );
  }
}
