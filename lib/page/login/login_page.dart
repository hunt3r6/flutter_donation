import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/auth_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F5F6),
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.go('/dashboard/home');
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case Loading():
              break;

            case Authenticated():
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.fillColored,
                title: Text('Login Berhasil'),
                description: Text('Selamat datang kembali'),
                alignment: Alignment.center,
                autoCloseDuration: const Duration(seconds: 3),
                animationBuilder: (context, animation, alignment, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                borderRadius: BorderRadius.circular(15.0),
                showProgressBar: true,
                closeOnClick: false,
                pauseOnHover: false,
                showIcon: false,
              );
              context.go('/dashboard/home');

              break;

            case Failure(error: String message):
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.fillColored,
                title: Text(message),
                description: Text('Cek kembali email dan password anda'),
                alignment: Alignment.center,
                autoCloseDuration: const Duration(seconds: 3),
                animationBuilder: (context, animation, alignment, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                borderRadius: BorderRadius.circular(15.0),
                showProgressBar: true,
                closeOnClick: false,
                pauseOnHover: false,
                showIcon: false,
              );
              break;
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/give_icon.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Masuk ke Akun',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AuthTextField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    hintText: 'Alamat Email',
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    prefixIcon: CupertinoIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukkan Alamat Email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Mohon Masukkan Alamat Email yang Valid';
                      }
                      return null;
                    },
                  ),
                  AuthTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    hintText: 'Password',
                    prefixIcon: CupertinoIcons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukkan Password';
                      }
                      if (value.length < 6) {
                        return 'Password harus 6 karakter atau lebih';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ActionButton(label: 'Masuk', onPressed: _login),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text(
                          'Daftar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEvent.loginRequested(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
