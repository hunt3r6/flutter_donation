import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/profile/profile_cubit.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/auth_text_field.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isUpdating = false; // To track update status

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Update Password',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              // Assuming ProfileCubit has a ProfileUpdating state
              if (state is ProfileUpdating) {
                setState(() {
                  _isUpdating = true;
                });
              } else if (state is ProfilePasswordUpdated) {
                setState(() {
                  _isUpdating = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Jika Anda ingin kembali ke halaman sebelumnya setelah update berhasil,
                // Anda bisa uncomment baris berikut:
                // Navigator.pop(context, true);
              } else if (state is ProfileError) {
                setState(() {
                  _isUpdating = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    AuthTextField(
                      controller: _passwordController,
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
                      controller: _confirmPasswordController,
                      hintText: 'Konfirmasi Password',
                      prefixIcon: CupertinoIcons.lock,
                      focusNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Password tidak sesuai';
                        }
                        if (value == null || value.isEmpty) {
                          return 'Mohon Konfirmasi Password';
                        }
                        if (value.length < 6) {
                          return 'Password harus 6 karakter atau lebih';
                        }
                        return null;
                      },
                    ),
                    ActionButton(
                      onPressed: _isUpdating ? null : _updatePassword,
                      label: _isUpdating ? 'Updating...' : 'Update Password',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().updatePassword(
        newPassword: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }
}
