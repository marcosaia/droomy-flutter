import 'package:droomy/service/workflows/base/workflow_repository.dart';
import 'package:droomy/service/workflows/firebase_workflow_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/workflow.dart';

final workflowRepositoryProvider =
    Provider<WorkflowRepository>((ref) => FirebaseWorkflowRepository());

final defaultWorkflowsProvider = FutureProvider<List<Workflow>>((ref) async {
  var workflows =
      await ref.watch(workflowRepositoryProvider).getDefaultWorkflows();
  return [workflows[0], workflows[0], workflows[0]];
});
