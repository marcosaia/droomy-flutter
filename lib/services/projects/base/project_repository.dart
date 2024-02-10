import 'package:droomy/data/models/project.dart';

abstract class ProjectRepository {
  /// Retrieves all projects from the repository
  Future<List<Project>> getAll();

  /// Adds a new project to the repository
  Future<bool> add(Project project);

  /// Updates the given project in the repository
  Future<bool> update(Project project);
}
