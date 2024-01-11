import 'package:droomy/services/workflows/base/workflow_repository.dart';
import 'package:droomy/services/workflows/firebase_workflow_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/workflow.dart';

final workflowRepositoryProvider =
    Provider<WorkflowRepository>((ref) => FirebaseWorkflowRepository());

final defaultWorkflowsProvider = FutureProvider<List<Workflow>>((ref) async {
  return await ref.watch(workflowRepositoryProvider).getDefaultWorkflows();
});
