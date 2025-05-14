import 'package:dio/dio.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/resource/local/auth_local_resource.dart';

class AuthInterceptor extends Interceptor {
  final AuthBloc authBloc;

  AuthInterceptor(this.authBloc);

  @override
  void onRequest(RequestOptions options, handler) async {
    final token = await AuthLocalResource.getToken();
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    if (token != null) {
      options.headers["Authorization"] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, handler) async {
    if (err.response?.statusCode == 401) {
      authBloc.add(const AuthEvent.logoutRequested());
      await AuthLocalResource.deleteToken();
    }
    super.onError(err, handler);
  }
}
