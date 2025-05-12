part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.registerSuccess({required String message}) =
      _RegisterSuccess;
  const factory AuthState.failure({required String error}) = Failure;
  const factory AuthState.registerFailure({
    required Map<String, dynamic> error,
  }) = RegisterFailure;
}
