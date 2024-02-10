import 'package:droomy/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_circular_button.dart';

class UserProfileAppBar extends ConsumerWidget implements PreferredSizeWidget {
  /// The current User, which will be displayed in the app bar
  final User currentUser;

  /// The app bar title
  final String appBarTitle;

  /// On User Profile touched
  final void Function(BuildContext context) onUserProfilePressed;

  const UserProfileAppBar({
    /// The user to display in the app bar
    required this.currentUser,

    /// A callback function called when the user presses on the user profile button
    required this.onUserProfilePressed,

    /// An optional title displayed as a label in the app bar
    this.appBarTitle = "",
    super.key,
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(appBarTitle),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: UserCircularButton(
            displayName: currentUser.displayName,
            imageUrl: currentUser.photoUrl,
            onPressed: () {
              onUserProfilePressed(context);
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
