import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/auth_text_field.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F5F6),
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              AuthTextField(
                hintText: 'Alamat Email',
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
              ActionButton(label: 'Masuk', onPressed: () {}),
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
    );
  }
}
