import 'package:droomy/data/models/workflow.dart';

abstract class WorkflowRepository {
  Future<List<Workflow>> getDefaultWorkflows();
}
