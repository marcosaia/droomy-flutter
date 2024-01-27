import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:droomy/services/authentication/base/auth_service.dart';

import '../../models/project.dart';
import './base/project_repository.dart';

class FirebaseProjectRepository extends ProjectRepository {
  // Dependencies
  final AuthService _authService;

  // Private utility properties
  String get _userId {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not logged in");
    }
    return userId;
  }

  FirebaseProjectRepository(this._authService);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Project> _fbGetProjectById(String projectId) async {
    DocumentSnapshot projectSnapshot = await _firestore
        .collection('users/$_userId/projects')
        .doc(projectId)
        .get();

    return Project.fromJson(projectSnapshot.data() as Map<String, dynamic>);
  }

  Future<List<Project>> _fbGetAllProjects() async {
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

  Future<void> _fbUpdateProject(
      String projectId, Project updatedProject) async {
    await _firestore
        .collection('users/$_userId/projects')
        .doc(projectId)
        .update(updatedProject.toJson());
  }

  Future<void> _fbAddProject(Project newProject) async {
    // Convert the new project to a map for Firestore
    Map<String, dynamic> projectMap = newProject.toJson();

    // Add the new project to the 'projects' collection
    await _firestore.collection('users/$_userId/projects').add(projectMap);
  }

  @override
  Future<bool> add(Project project) async {
    await _fbAddProject(project);
    return true;
  }

  @override
  Future<List<Project>> getAll() async {
    return _fbGetAllProjects();
  }

  @override
  Future<bool> update(Project project) async {
    print("Updating project with ID ${project.projectId}");
    await _fbUpdateProject(project.projectId, project);
    return true;
  }
}
