import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/bloc/profile/profile_cubit.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/resource/model/user_model.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Map<String, dynamic>> menuItems = [
    {'title': 'Profile Saya', 'icon': Icons.person, 'route': '/update_profile'},
    {'title': 'Ubah Password', 'icon': Icons.lock, 'route': '/update_password'},
    {
      'title': 'Donasi Saya',
      'icon': Icons.favorite,
      'route': '/dashboard/my_donations',
    },
  ];

  late UserModel user = UserModel();

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() {
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoaded) {
                setState(() {
                  user = state.user;
                });
              }
            },
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: '${user.avatar}',
                      placeholder:
                          (context, url) =>
                              Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${user.name}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${user.email}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final menuItem = menuItems[index];
                    return _buildMenuItem(
                      menuItem['title'],
                      menuItem['icon'],
                      () async {
                        final result = await context.push(menuItem['route']);
                        if (result != null) {
                          getProfile();
                        }
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  child: ActionButton(
                    label: 'Keluar',
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthEvent.logoutRequested());
                      context.push('/login');
                    },
                    colorButton: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
