import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../widget/user_circular_button.dart';

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileAppBar({
    super.key,
    required this.currentUser,
    this.appBarTitle = "",
  }) : super();

  final User currentUser;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Overview"),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
