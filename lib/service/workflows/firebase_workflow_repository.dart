import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droomy/model/workflow.dart';

import '../../model/workflow_step.dart';
import 'base/workflow_repository.dart';

class FirebaseWorkflowRepository extends WorkflowRepository {
  @override
  Future<List<Workflow>> getDefaultWorkflows() async {
    List<Workflow> workflows = [];

    try {
      QuerySnapshot<Map<String, dynamic>> workflowSnapshot =
          await FirebaseFirestore.instance
              .collection('default_workflows')
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> workflowDocument
          in workflowSnapshot.docs) {
        Workflow workflow = Workflow.fromJson(workflowDocument.data());

        // Fetch steps for each workflow
        QuerySnapshot<Map<String, dynamic>> stepsSnapshot =
            await FirebaseFirestore.instance
                .collection('default_workflows')
                .doc(workflowDocument.id)
                .collection('steps') // Sub-collection 'steps'
                .get();

        List<WorkflowStep> steps = stepsSnapshot.docs.map((stepDocument) {
          return WorkflowStep.fromJson(stepDocument.data());
        }).toList();

        workflow.steps = steps;
        workflows.add(workflow);
      }
    } catch (e) {
      print('Error retrieving workflows with steps: $e');
    }

    return workflows;
  }
}
