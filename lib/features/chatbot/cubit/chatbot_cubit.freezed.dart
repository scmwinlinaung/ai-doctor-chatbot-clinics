// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatbot_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatbotState {
  List<ChatMessageModel> get messages => throw _privateConstructorUsedError;
  bool get isAiTyping => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotStateCopyWith<ChatbotState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotStateCopyWith<$Res> {
  factory $ChatbotStateCopyWith(
          ChatbotState value, $Res Function(ChatbotState) then) =
      _$ChatbotStateCopyWithImpl<$Res, ChatbotState>;
  @useResult
  $Res call({List<ChatMessageModel> messages, bool isAiTyping});
}

/// @nodoc
class _$ChatbotStateCopyWithImpl<$Res, $Val extends ChatbotState>
    implements $ChatbotStateCopyWith<$Res> {
  _$ChatbotStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isAiTyping = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      isAiTyping: null == isAiTyping
          ? _value.isAiTyping
          : isAiTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatbotStateImplCopyWith<$Res>
    implements $ChatbotStateCopyWith<$Res> {
  factory _$$ChatbotStateImplCopyWith(
          _$ChatbotStateImpl value, $Res Function(_$ChatbotStateImpl) then) =
      __$$ChatbotStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChatMessageModel> messages, bool isAiTyping});
}

/// @nodoc
class __$$ChatbotStateImplCopyWithImpl<$Res>
    extends _$ChatbotStateCopyWithImpl<$Res, _$ChatbotStateImpl>
    implements _$$ChatbotStateImplCopyWith<$Res> {
  __$$ChatbotStateImplCopyWithImpl(
      _$ChatbotStateImpl _value, $Res Function(_$ChatbotStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isAiTyping = null,
  }) {
    return _then(_$ChatbotStateImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      isAiTyping: null == isAiTyping
          ? _value.isAiTyping
          : isAiTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChatbotStateImpl implements _ChatbotState {
  const _$ChatbotStateImpl(
      {final List<ChatMessageModel> messages = const [],
      this.isAiTyping = false})
      : _messages = messages;

  final List<ChatMessageModel> _messages;
  @override
  @JsonKey()
  List<ChatMessageModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isAiTyping;

  @override
  String toString() {
    return 'ChatbotState(messages: $messages, isAiTyping: $isAiTyping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotStateImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isAiTyping, isAiTyping) ||
                other.isAiTyping == isAiTyping));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_messages), isAiTyping);

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotStateImplCopyWith<_$ChatbotStateImpl> get copyWith =>
      __$$ChatbotStateImplCopyWithImpl<_$ChatbotStateImpl>(this, _$identity);
}

abstract class _ChatbotState implements ChatbotState {
  const factory _ChatbotState(
      {final List<ChatMessageModel> messages,
      final bool isAiTyping}) = _$ChatbotStateImpl;

  @override
  List<ChatMessageModel> get messages;
  @override
  bool get isAiTyping;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotStateImplCopyWith<_$ChatbotStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
