import 'package:flutter/material.dart';

import '../../../../model/workflow.dart';

class ConfirmationScreen extends StatelessWidget {
  final String title;
  final String projectName;
  final Workflow workflow;

  const ConfirmationScreen({
    Key? key,
    required this.title,
    required this.projectName,
    required this.workflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Let\'s have fun with your new project:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(projectName,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 16),
            Text(
              'Using our dream flow: ${workflow.displayName}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set your desired border radius here
                      ),
                    ),
                    onPressed: () => {
                      // TODO: Create new project and navigate to dashboard
                    },
                    child: const Text('LET\'S GO'),
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
