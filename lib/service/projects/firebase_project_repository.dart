import 'package:droomy/model/project.dart';

import './base/project_repository.dart';

class FirebaseProjectRepository extends ProjectRepository {
  final List<Project> _projects = [];

  @override
  Future<bool> add(Project project) async {
    _projects.add(project);
    return true;
  }

  @override
  Future<List<Project>> getAll() async {
    return _projects;
  }

  @override
  Future<bool> update(Project project) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
