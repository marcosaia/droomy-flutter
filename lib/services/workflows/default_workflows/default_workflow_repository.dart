import 'package:droomy/data/models/workflow.dart';
import 'package:droomy/services/workflows/base/workflow_repository.dart';
import 'package:droomy/services/workflows/default_workflows/workflows/full_cycle_workflow.dart';

class DefaultWorkflowRepository extends WorkflowRepository {
  List<Workflow> _workflows = [];

  DefaultWorkflowRepository() {
    _workflows = [FullCycleWorkflow()];
  }

  @override
  Future<List<Workflow>> getDefaultWorkflows() async {
    return _workflows;
  }
}
