import 'package:droomy/common/constants.dart';
import 'package:droomy/screens/project_wizard/controllers/project_wizard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/screens/dashboard_screen.dart';

class ConfirmationScreen extends ConsumerWidget {
  final String title;

  const ConfirmationScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.read(projectWizardControllerProvider);
    var controller = ref.read(projectWizardControllerProvider.notifier);

    // Project Title
    final projectTitle = state.projectTitle;
    if (projectTitle == null) {
      throw Exception("Missing required parameter 'projectTitle'");
    }

    // Selected Workflow
    final workflow = state.workflow;
    if (workflow == null) {
      throw Exception("Missing required parameter 'workflow'");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.paddingRegular),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Let\'s have fun with your new project:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: Constants.paddingRegular),
            Text(projectTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: Constants.paddingRegular),
            Text(
              'Using our dream flow: ${workflow.displayName}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: Constants.paddingBig),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: Constants.paddingRegular),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set your desired border radius here
                      ),
                    ),
                    onPressed: () async {
                      final success = await controller.createProject(
                          projectTitle, workflow);
                      if (success && context.mounted) {
                        ref.invalidate(projectWizardControllerProvider);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: const Text('CONFIRM'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
