import '../../../model/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getAll();
  Future<bool> add(Project project);
  Future<bool> update(Project project);
}
