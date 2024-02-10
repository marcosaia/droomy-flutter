import 'package:droomy/data/models/workflow.dart';
import 'package:droomy/services/workflows/default_workflows/steps/steps.dart';

class FullCycleWorkflow extends Workflow {
  FullCycleWorkflow(
      {super.identifier = "full_cycle", super.displayName = "Full Cycle"}) {
    steps = [
      DefaultWorkflowSteps.demo,
      DefaultWorkflowSteps.recording,
      DefaultWorkflowSteps.mixing,
      DefaultWorkflowSteps.mastering,
    ];
  }
}
