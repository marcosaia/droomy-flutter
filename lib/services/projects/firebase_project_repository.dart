import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';

import './base/project_repository.dart';

class FirebaseProjectRepository extends ProjectRepository {
  // Dependencies
  final AuthService _authService;
  final FirebaseFirestore _firestore;

  // Private properties
  String get _userId {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not logged in");
    }
    return userId;
  }

  // Constructor
  FirebaseProjectRepository(this._authService, this._firestore);

  // Implementation
  @override
  Future<List<Project>> getAll() async {
    List<Project> projects = [];
    var projectSnapshot =
        await _firestore.collection('users/$_userId/projects').get();
    for (var document in projectSnapshot.docs) {
      // Create the Project from JSON
      Project project = Project.fromJson(document.data());

      // Set the project ID to match the document ID
      project.projectId = document.id;

      // Add the Project to the list
      projects.add(project);
    }

    return projects;
  }

  @override
  Future<bool> add(Project project) async {
    // Convert the new project to a map for Firestore
    Map<String, dynamic> projectMap = project.toJson();

    // Add the new project to the 'projects' collection
    _firestore.collection('users/$_userId/projects').add(projectMap);

    return true;
  }

  @override
  Future<bool> update(Project project) async {
    _firestore
        .collection('users/$_userId/projects')
        .doc(project.projectId)
        .update(project.toJson());
    return true;
  }
}
