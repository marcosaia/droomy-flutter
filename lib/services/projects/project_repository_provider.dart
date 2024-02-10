import 'package:droomy/common/global_providers.dart';
import 'package:droomy/services/authentication/auth_service_provider.dart';
import 'package:droomy/services/projects/base/project_repository.dart';
import 'package:droomy/services/projects/firebase_project_repository.dart';
import 'package:riverpod/riverpod.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final authService = ref.read(authServiceProvider);
  final firestore = ref.read(firestoreProvider);
  return FirebaseProjectRepository(authService, firestore);
});
