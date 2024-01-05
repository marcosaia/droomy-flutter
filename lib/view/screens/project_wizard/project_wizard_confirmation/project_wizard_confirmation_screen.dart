import 'package:droomy/model/project.dart';
import 'package:droomy/service/projects/project_repository_provider.dart';
import 'package:droomy/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/workflow.dart';

class ConfirmationScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    var projectRepository = ref.watch(projectRepositoryProvider);

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
                    onPressed: () async {
                      Project project = Project(
                          workflow: workflow,
                          projectId: 'test_project', // TODO: Use unique IDs
                          title: projectName);
                      projectRepository.add(project);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()),
                          (Route<dynamic> route) => false);
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
