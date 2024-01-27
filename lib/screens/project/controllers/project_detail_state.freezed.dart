// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectDetailState {
  Project? get project => throw _privateConstructorUsedError;
  ViewState get viewState => throw _privateConstructorUsedError;
  bool get areGoalsCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectDetailStateCopyWith<ProjectDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectDetailStateCopyWith<$Res> {
  factory $ProjectDetailStateCopyWith(
          ProjectDetailState value, $Res Function(ProjectDetailState) then) =
      _$ProjectDetailStateCopyWithImpl<$Res, ProjectDetailState>;
  @useResult
  $Res call({Project? project, ViewState viewState, bool areGoalsCompleted});

  $ViewStateCopyWith<$Res> get viewState;
}

/// @nodoc
class _$ProjectDetailStateCopyWithImpl<$Res, $Val extends ProjectDetailState>
    implements $ProjectDetailStateCopyWith<$Res> {
  _$ProjectDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = freezed,
    Object? viewState = null,
    Object? areGoalsCompleted = null,
  }) {
    return _then(_value.copyWith(
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Project?,
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ViewState,
      areGoalsCompleted: null == areGoalsCompleted
          ? _value.areGoalsCompleted
          : areGoalsCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ViewStateCopyWith<$Res> get viewState {
    return $ViewStateCopyWith<$Res>(_value.viewState, (value) {
      return _then(_value.copyWith(viewState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectDetailStateImplCopyWith<$Res>
    implements $ProjectDetailStateCopyWith<$Res> {
  factory _$$ProjectDetailStateImplCopyWith(_$ProjectDetailStateImpl value,
          $Res Function(_$ProjectDetailStateImpl) then) =
      __$$ProjectDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Project? project, ViewState viewState, bool areGoalsCompleted});

  @override
  $ViewStateCopyWith<$Res> get viewState;
}

/// @nodoc
class __$$ProjectDetailStateImplCopyWithImpl<$Res>
    extends _$ProjectDetailStateCopyWithImpl<$Res, _$ProjectDetailStateImpl>
    implements _$$ProjectDetailStateImplCopyWith<$Res> {
  __$$ProjectDetailStateImplCopyWithImpl(_$ProjectDetailStateImpl _value,
      $Res Function(_$ProjectDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = freezed,
    Object? viewState = null,
    Object? areGoalsCompleted = null,
  }) {
    return _then(_$ProjectDetailStateImpl(
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Project?,
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ViewState,
      areGoalsCompleted: null == areGoalsCompleted
          ? _value.areGoalsCompleted
          : areGoalsCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProjectDetailStateImpl implements _ProjectDetailState {
  _$ProjectDetailStateImpl(
      {required this.project,
      required this.viewState,
      this.areGoalsCompleted = true});

  @override
  final Project? project;
  @override
  final ViewState viewState;
  @override
  @JsonKey()
  final bool areGoalsCompleted;

  @override
  String toString() {
    return 'ProjectDetailState(project: $project, viewState: $viewState, areGoalsCompleted: $areGoalsCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectDetailStateImpl &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.viewState, viewState) ||
                other.viewState == viewState) &&
            (identical(other.areGoalsCompleted, areGoalsCompleted) ||
                other.areGoalsCompleted == areGoalsCompleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, project, viewState, areGoalsCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectDetailStateImplCopyWith<_$ProjectDetailStateImpl> get copyWith =>
      __$$ProjectDetailStateImplCopyWithImpl<_$ProjectDetailStateImpl>(
          this, _$identity);
}

abstract class _ProjectDetailState implements ProjectDetailState {
  factory _ProjectDetailState(
      {required final Project? project,
      required final ViewState viewState,
      final bool areGoalsCompleted}) = _$ProjectDetailStateImpl;

  @override
  Project? get project;
  @override
  ViewState get viewState;
  @override
  bool get areGoalsCompleted;
  @override
  @JsonKey(ignore: true)
  _$$ProjectDetailStateImplCopyWith<_$ProjectDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
