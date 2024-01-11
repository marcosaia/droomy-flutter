import 'package:droomy/models/project.dart';
import 'package:droomy/services/projects/base/project_repository.dart';

/// Quick mocked repository implementation
class MockedProjectRepository extends ProjectRepository {
  List<Project> mockedProjects = [
    Project(title: 'Love Song', projectId: '0001', workflow: null),
    Project(title: 'Sadness Ballad', projectId: '0002', workflow: null),
  ];

  @override
  Future<List<Project>> getAll() async {
    return mockedProjects;
  }

  @override
  Future<bool> add(Project project) => throw UnimplementedError();

  @override
  Future<bool> update(Project project) => throw UnimplementedError();
}
