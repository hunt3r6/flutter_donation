part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = AuthLogin;

  const factory AuthEvent.registerRequested({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) = AuthRegister;

  const factory AuthEvent.checkLoginStatus() = CheckLoginStatus;
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
