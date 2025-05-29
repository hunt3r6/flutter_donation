// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donate_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonateState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonateState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonateState()';
}


}

/// @nodoc
class $DonateStateCopyWith<$Res>  {
$DonateStateCopyWith(DonateState _, $Res Function(DonateState) __);
}


/// @nodoc


class DonateInitial implements DonateState {
  const DonateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonateState.initial()';
}


}




/// @nodoc


class DonateLoading implements DonateState {
  const DonateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonateState.loading()';
}


}




/// @nodoc


class DonateSuccess implements DonateState {
  const DonateSuccess(this.snapToken);
  

 final  String snapToken;

/// Create a copy of DonateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonateSuccessCopyWith<DonateSuccess> get copyWith => _$DonateSuccessCopyWithImpl<DonateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonateSuccess&&(identical(other.snapToken, snapToken) || other.snapToken == snapToken));
}


@override
int get hashCode => Object.hash(runtimeType,snapToken);

@override
String toString() {
  return 'DonateState.success(snapToken: $snapToken)';
}


}

/// @nodoc
abstract mixin class $DonateSuccessCopyWith<$Res> implements $DonateStateCopyWith<$Res> {
  factory $DonateSuccessCopyWith(DonateSuccess value, $Res Function(DonateSuccess) _then) = _$DonateSuccessCopyWithImpl;
@useResult
$Res call({
 String snapToken
});




}
/// @nodoc
class _$DonateSuccessCopyWithImpl<$Res>
    implements $DonateSuccessCopyWith<$Res> {
  _$DonateSuccessCopyWithImpl(this._self, this._then);

  final DonateSuccess _self;
  final $Res Function(DonateSuccess) _then;

/// Create a copy of DonateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? snapToken = null,}) {
  return _then(DonateSuccess(
null == snapToken ? _self.snapToken : snapToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DonateError implements DonateState {
  const DonateError(this.message);
  

 final  String message;

/// Create a copy of DonateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonateErrorCopyWith<DonateError> get copyWith => _$DonateErrorCopyWithImpl<DonateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DonateState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DonateErrorCopyWith<$Res> implements $DonateStateCopyWith<$Res> {
  factory $DonateErrorCopyWith(DonateError value, $Res Function(DonateError) _then) = _$DonateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DonateErrorCopyWithImpl<$Res>
    implements $DonateErrorCopyWith<$Res> {
  _$DonateErrorCopyWithImpl(this._self, this._then);

  final DonateError _self;
  final $Res Function(DonateError) _then;

/// Create a copy of DonateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DonateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
