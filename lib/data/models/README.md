
# Using `json_serializable` in Flutter for Declaring Models

This app uses `json_serializable`

It automates Dart object JSON serialization, simplifying data handling.

## Setting up Models

### 1. Define Dart Classes

Create Dart classes for models:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; // Generated file

@JsonSerializable()
class User {
  final String id;
  final String name;
  
  User({required this.id, required this.name});
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 2. Annotate Model Classes

Use `@JsonSerializable()` to mark classes for code generation.

### 3. Run Code Generation

Run this command to generate serialization code (the .g.dart files):

```bash
dart run build_runner build
```

### 4. Usage

Use `fromJson()` and `toJson()` methods for serialization/deserialization.

**Happy Coding!** 🚀📱