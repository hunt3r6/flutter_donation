import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/local/auth_local_resource.dart';
import 'package:flutter_donation/resource/local/user_local_resource.dart';
import 'package:flutter_donation/resource/remote/auth_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteResource authRemoteResource;
  AuthBloc(this.authRemoteResource) : super(Initial()) {
    on<AuthLogin>(_onLoginRequested);
    on<AuthRegister>(_onRegisterRequested);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// Handle login request event.
  Future<void> _onLoginRequested(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final result = await authRemoteResource.login(event.email, event.password);
    await result.fold(
      (error) async {
        emit(AuthState.failure(error: error));
      },
      (response) async {
        await AuthLocalResource.saveToken(response.token ?? '');
        emit(AuthState.authenticated());
      },
    );
  }

  /// Handle register request event.
  Future<void> _onRegisterRequested(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final result = await authRemoteResource.register(
      event.name,
      event.email,
      event.password,
      event.passwordConfirmation,
    );
    await result.fold(
      (error) async {
        if (error is Map<String, dynamic>) {
          emit(AuthState.registerFailure(error: error));
        } else {
          emit(AuthState.failure(error: error.toString()));
        }
      },
      (message) async {
        emit(AuthState.registerSuccess(message: message));
      },
    );
  }

  /// Handle check login status event.
  Future<void> _onCheckLoginStatus(
    CheckLoginStatus event,
    Emitter<AuthState> emit,
  ) async {
    final token = await AuthLocalResource.getToken();
    if (token != null) {
      emit(AuthState.authenticated());
    } else {
      emit(AuthState.unauthenticated());
    }
  }

  /// Handle logout request event.
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    await AuthLocalResource.deleteToken();
    await UserLocalResource.deleteUser();
    emit(AuthState.unauthenticated());
  }
}
