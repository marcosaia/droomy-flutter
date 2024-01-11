// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectWizardState {
  String? get projectTitle => throw _privateConstructorUsedError;
  Workflow? get workflow => throw _privateConstructorUsedError;
  bool get isProjectTitleValid => throw _privateConstructorUsedError;
  ViewState get viewState => throw _privateConstructorUsedError;
  List<Workflow> get workflows => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectWizardStateCopyWith<ProjectWizardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectWizardStateCopyWith<$Res> {
  factory $ProjectWizardStateCopyWith(
          ProjectWizardState value, $Res Function(ProjectWizardState) then) =
      _$ProjectWizardStateCopyWithImpl<$Res, ProjectWizardState>;
  @useResult
  $Res call(
      {String? projectTitle,
      Workflow? workflow,
      bool isProjectTitleValid,
      ViewState viewState,
      List<Workflow> workflows});

  $ViewStateCopyWith<$Res> get viewState;
}

/// @nodoc
class _$ProjectWizardStateCopyWithImpl<$Res, $Val extends ProjectWizardState>
    implements $ProjectWizardStateCopyWith<$Res> {
  _$ProjectWizardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectTitle = freezed,
    Object? workflow = freezed,
    Object? isProjectTitleValid = null,
    Object? viewState = null,
    Object? workflows = null,
  }) {
    return _then(_value.copyWith(
      projectTitle: freezed == projectTitle
          ? _value.projectTitle
          : projectTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      workflow: freezed == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as Workflow?,
      isProjectTitleValid: null == isProjectTitleValid
          ? _value.isProjectTitleValid
          : isProjectTitleValid // ignore: cast_nullable_to_non_nullable
              as bool,
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ViewState,
      workflows: null == workflows
          ? _value.workflows
          : workflows // ignore: cast_nullable_to_non_nullable
              as List<Workflow>,
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
abstract class _$$ProjectWizardStateImplCopyWith<$Res>
    implements $ProjectWizardStateCopyWith<$Res> {
  factory _$$ProjectWizardStateImplCopyWith(_$ProjectWizardStateImpl value,
          $Res Function(_$ProjectWizardStateImpl) then) =
      __$$ProjectWizardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? projectTitle,
      Workflow? workflow,
      bool isProjectTitleValid,
      ViewState viewState,
      List<Workflow> workflows});

  @override
  $ViewStateCopyWith<$Res> get viewState;
}

/// @nodoc
class __$$ProjectWizardStateImplCopyWithImpl<$Res>
    extends _$ProjectWizardStateCopyWithImpl<$Res, _$ProjectWizardStateImpl>
    implements _$$ProjectWizardStateImplCopyWith<$Res> {
  __$$ProjectWizardStateImplCopyWithImpl(_$ProjectWizardStateImpl _value,
      $Res Function(_$ProjectWizardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectTitle = freezed,
    Object? workflow = freezed,
    Object? isProjectTitleValid = null,
    Object? viewState = null,
    Object? workflows = null,
  }) {
    return _then(_$ProjectWizardStateImpl(
      projectTitle: freezed == projectTitle
          ? _value.projectTitle
          : projectTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      workflow: freezed == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as Workflow?,
      isProjectTitleValid: null == isProjectTitleValid
          ? _value.isProjectTitleValid
          : isProjectTitleValid // ignore: cast_nullable_to_non_nullable
              as bool,
      viewState: null == viewState
          ? _value.viewState
          : viewState // ignore: cast_nullable_to_non_nullable
              as ViewState,
      workflows: null == workflows
          ? _value._workflows
          : workflows // ignore: cast_nullable_to_non_nullable
              as List<Workflow>,
    ));
  }
}

/// @nodoc

class _$ProjectWizardStateImpl implements _ProjectWizardState {
  const _$ProjectWizardStateImpl(
      {this.projectTitle,
      this.workflow,
      this.isProjectTitleValid = false,
      required this.viewState,
      final List<Workflow> workflows = const []})
      : _workflows = workflows;

  @override
  final String? projectTitle;
  @override
  final Workflow? workflow;
  @override
  @JsonKey()
  final bool isProjectTitleValid;
  @override
  final ViewState viewState;
  final List<Workflow> _workflows;
  @override
  @JsonKey()
  List<Workflow> get workflows {
    if (_workflows is EqualUnmodifiableListView) return _workflows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workflows);
  }

  @override
  String toString() {
    return 'ProjectWizardState(projectTitle: $projectTitle, workflow: $workflow, isProjectTitleValid: $isProjectTitleValid, viewState: $viewState, workflows: $workflows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectWizardStateImpl &&
            (identical(other.projectTitle, projectTitle) ||
                other.projectTitle == projectTitle) &&
            (identical(other.workflow, workflow) ||
                other.workflow == workflow) &&
            (identical(other.isProjectTitleValid, isProjectTitleValid) ||
                other.isProjectTitleValid == isProjectTitleValid) &&
            (identical(other.viewState, viewState) ||
                other.viewState == viewState) &&
            const DeepCollectionEquality()
                .equals(other._workflows, _workflows));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectTitle,
      workflow,
      isProjectTitleValid,
      viewState,
      const DeepCollectionEquality().hash(_workflows));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectWizardStateImplCopyWith<_$ProjectWizardStateImpl> get copyWith =>
      __$$ProjectWizardStateImplCopyWithImpl<_$ProjectWizardStateImpl>(
          this, _$identity);
}

abstract class _ProjectWizardState implements ProjectWizardState {
  const factory _ProjectWizardState(
      {final String? projectTitle,
      final Workflow? workflow,
      final bool isProjectTitleValid,
      required final ViewState viewState,
      final List<Workflow> workflows}) = _$ProjectWizardStateImpl;

  @override
  String? get projectTitle;
  @override
  Workflow? get workflow;
  @override
  bool get isProjectTitleValid;
  @override
  ViewState get viewState;
  @override
  List<Workflow> get workflows;
  @override
  @JsonKey(ignore: true)
  _$$ProjectWizardStateImplCopyWith<_$ProjectWizardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
