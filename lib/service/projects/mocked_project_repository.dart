import 'package:droomy/model/project.dart';
import 'package:droomy/service/projects/base/project_repository.dart';

class MockedProjectRepository extends ProjectRepository {
  List<Project> mockedProjects = [
    Project(title: 'Love Song', projectId: '0001'),
    Project(title: 'Sadness Ballad', projectId: '0002'),
  ];

  @override
  Future<bool> add(Project project) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getAll() async {
    return mockedProjects;
  }

  @override
  Future<bool> update(Project project) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
