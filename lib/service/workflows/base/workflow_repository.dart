import '../../../model/workflow.dart';

abstract class WorkflowRepository {
  Future<List<Workflow>> getDefaultWorkflows();
}
