import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provides a valid and configured instance of Firebase Firestore
final firestoreProvider = StateProvider<FirebaseFirestore>((_) {
  final firestore = FirebaseFirestore.instance;
  // Enable local persistence to use Firestore Local Caching
  firestore.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  return firestore;
});
