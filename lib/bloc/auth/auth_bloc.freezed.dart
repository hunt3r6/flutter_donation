// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// @nodoc


class AuthLogin implements AuthEvent {
  const AuthLogin({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthLoginCopyWith<AuthLogin> get copyWith => _$AuthLoginCopyWithImpl<AuthLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.loginRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthLoginCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthLoginCopyWith(AuthLogin value, $Res Function(AuthLogin) _then) = _$AuthLoginCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthLoginCopyWithImpl<$Res>
    implements $AuthLoginCopyWith<$Res> {
  _$AuthLoginCopyWithImpl(this._self, this._then);

  final AuthLogin _self;
  final $Res Function(AuthLogin) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthLogin(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthRegister implements AuthEvent {
  const AuthRegister({required this.name, required this.email, required this.password, required this.passwordConfirmation});
  

 final  String name;
 final  String email;
 final  String password;
 final  String passwordConfirmation;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthRegisterCopyWith<AuthRegister> get copyWith => _$AuthRegisterCopyWithImpl<AuthRegister>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthRegister&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,password,passwordConfirmation);

@override
String toString() {
  return 'AuthEvent.registerRequested(name: $name, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
}


}

/// @nodoc
abstract mixin class $AuthRegisterCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthRegisterCopyWith(AuthRegister value, $Res Function(AuthRegister) _then) = _$AuthRegisterCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password, String passwordConfirmation
});




}
/// @nodoc
class _$AuthRegisterCopyWithImpl<$Res>
    implements $AuthRegisterCopyWith<$Res> {
  _$AuthRegisterCopyWithImpl(this._self, this._then);

  final AuthRegister _self;
  final $Res Function(AuthRegister) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(AuthRegister(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckLoginStatus implements AuthEvent {
  const CheckLoginStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckLoginStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkLoginStatus()';
}


}




/// @nodoc


class LogoutRequested implements AuthEvent {
  const LogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}




/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// @nodoc


class Initial implements AuthState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class Loading implements AuthState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class Authenticated implements AuthState {
  const Authenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticated()';
}


}




/// @nodoc


class Unauthenticated implements AuthState {
  const Unauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class RegisterSuccess implements AuthState {
  const RegisterSuccess({required this.message});
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSuccessCopyWith<RegisterSuccess> get copyWith => _$RegisterSuccessCopyWithImpl<RegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.registerSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $RegisterSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $RegisterSuccessCopyWith(RegisterSuccess value, $Res Function(RegisterSuccess) _then) = _$RegisterSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RegisterSuccessCopyWithImpl<$Res>
    implements $RegisterSuccessCopyWith<$Res> {
  _$RegisterSuccessCopyWithImpl(this._self, this._then);

  final RegisterSuccess _self;
  final $Res Function(RegisterSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RegisterSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Failure implements AuthState {
  const Failure({required this.error});
  

 final  String error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Failure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterFailure implements AuthState {
  const RegisterFailure({required final  Map<String, dynamic> error}): _error = error;
  

 final  Map<String, dynamic> _error;
 Map<String, dynamic> get error {
  if (_error is EqualUnmodifiableMapView) return _error;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_error);
}


/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFailureCopyWith<RegisterFailure> get copyWith => _$RegisterFailureCopyWithImpl<RegisterFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFailure&&const DeepCollectionEquality().equals(other._error, _error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_error));

@override
String toString() {
  return 'AuthState.registerFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $RegisterFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $RegisterFailureCopyWith(RegisterFailure value, $Res Function(RegisterFailure) _then) = _$RegisterFailureCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> error
});




}
/// @nodoc
class _$RegisterFailureCopyWithImpl<$Res>
    implements $RegisterFailureCopyWith<$Res> {
  _$RegisterFailureCopyWithImpl(this._self, this._then);

  final RegisterFailure _self;
  final $Res Function(RegisterFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(RegisterFailure(
error: null == error ? _self._error : error // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
