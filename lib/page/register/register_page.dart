import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/auth_text_field.dart';
import 'package:flutter_donation/core/widget/form_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
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
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case RegisterSuccess(message: String message):
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.fillColored,
                title: Text(message),
                description: Text('Silakan Masuk ke Akun Anda'),
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
              context.pop();
              break;

            case RegisterFailure(error: Map<String, dynamic> error):
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.fillColored,
                title: Text(error['message']),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  FormTextField(
                    hintText: 'Nama Lengkap',
                    focusNode: _fullNameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    prefixIcon: CupertinoIcons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukkan Nama Lengkap';
                      }
                      return null;
                    },
                  ),
                  AuthTextField(
                    hintText: 'Alamat Email',
                    prefixIcon: CupertinoIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Alamat Email';
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
                    hintText: 'Password',
                    prefixIcon: CupertinoIcons.lock,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(
                        context,
                      ).requestFocus(_confirmPasswordFocus);
                    },
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
                  AuthTextField(
                    hintText: 'Konfirmasi Password',
                    prefixIcon: CupertinoIcons.lock,
                    focusNode: _confirmPasswordFocus,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Konfirmasi Password';
                      }
                      if (value.length < 6) {
                        return 'Password harus 6 karakter atau lebih';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ActionButton(label: 'Daftar', onPressed: _register),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Sudah punya akun? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          'Masuk',
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

  void _register() {
    if (_formKey.currentState!.validate()) {
      final name = _fullNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      context.read<AuthBloc>().add(
        AuthEvent.registerRequested(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: password,
        ),
      );
    }
  }
}
