import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droomy/models/workflow.dart';

import '../../models/workflow_step.dart';
import 'base/workflow_repository.dart';

class FirebaseWorkflowRepository extends WorkflowRepository {
  @override
  Future<List<Workflow>> getDefaultWorkflows() async {
    List<Workflow> workflows = [];

    try {
      // Fetch Workflows from Firebase
      var workflowsSnapshot = await _fetchDefaultWorkflows();

      for (var document in workflowsSnapshot.docs) {
        // Create the Workflow from JSON
        Workflow workflow = Workflow.fromJson(document.data());

        // Fetch Workflow steps from Firebase
        var stepsSnapshot = await _fetchWorkflowSteps(document);

        // Create Workflow steps from JSON
        workflow.steps = stepsSnapshot.docs.map((stepDocument) {
          return WorkflowStep.fromJson(stepDocument.data());
        }).toList();

        // Add the Workflow to the list
        workflows.add(workflow);
      }
    } catch (e) {
      print('Error retrieving workflows with steps: $e');
    }

    return workflows;
  }

  /// Private utility method to fetch the Default Workflows collection on the Firebase Cloudstore
  Future<QuerySnapshot<Map<String, dynamic>>> _fetchDefaultWorkflows() {
    return FirebaseFirestore.instance.collection('default_workflows').get();
  }

  /// Private utility method to fetch the Workflow Steps on the Firebase Cloudstore
  Future<QuerySnapshot<Map<String, dynamic>>> _fetchWorkflowSteps(
      QueryDocumentSnapshot documentSnapshot) {
    return FirebaseFirestore.instance
        .collection('default_workflows')
        .doc(documentSnapshot.id)
        .collection('steps') // Sub-collection 'steps'
        .get();
  }
}
