import 'package:droomy/common/constants.dart';
import 'package:droomy/common/theme.dart';
import 'package:droomy/screens/debug/debug_color_grid_screen.dart';
import 'package:droomy/screens/login/screens/login_screen.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/widgets/theme_switch.dart';
import 'package:droomy/widgets/user_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardEndDrawer extends ConsumerWidget {
  const DashboardEndDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      return Container();
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Text(
                  currentUser.displayName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(
                  height: Constants.paddingRegular,
                ),
                UserCircularButton(
                    displayName: currentUser.displayName,
                    imageUrl: currentUser.photoUrl)
              ],
            ),
          ),
          ListTile(
            leading: const ThemeSwitch(),
            title: Text(ref.read(isDarkModeProvider)
                ? 'Turn on the lights'
                : 'Turn off the lights'),
            onTap: () {
              ref.read(isDarkModeProvider.notifier).state =
                  !(ref.read(isDarkModeProvider));
            },
          ),
          ListTile(
              title: const Text('Debug Colors'),
              onTap: () async {
                if (!context.mounted) {
                  return;
                }

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DebugColorGridScreen()));
              }),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () async {
              await auth.signOut();
              if (!context.mounted) {
                return;
              }
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            },
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}
