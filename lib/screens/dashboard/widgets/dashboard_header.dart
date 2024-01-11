import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../project_wizard/screens/project_wizard_title_screen.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    required this.currentUser,
  });

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
