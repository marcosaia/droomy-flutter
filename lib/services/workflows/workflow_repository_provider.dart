import 'package:droomy/services/workflows/base/workflow_repository.dart';
import 'package:droomy/services/workflows/default_workflows/default_workflow_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workflowRepositoryProvider = Provider<WorkflowRepository>((ref) {
  return DefaultWorkflowRepository();
});
