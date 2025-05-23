import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/profile/profile_cubit.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/core/widget/form_text_field.dart';
import 'package:flutter_donation/resource/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  late UserModel user = UserModel();

  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak ada gambar dipilih')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Update Profile',
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
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is ProfileLoaded) {
                setState(() {
                  user = state.user;
                  _nameController.text = user.name ?? '';
                  _emailController.text = user.email ?? '';
                });
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            _image != null
                                ? Image.file(
                                  _image!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                                : CachedNetworkImage(
                                  imageUrl: '${user.avatar}',
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await _showImageSourceActionSheet();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FormTextField(
                    controller: _nameController,
                    hintText: 'Nama Lengkap',
                    prefixIcon: CupertinoIcons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Masukkan Nama Lengkap';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    enabled: false,
                    controller: _emailController,
                    hintText: 'Alamat Email',
                    prefixIcon: CupertinoIcons.mail,
                  ),
                  const SizedBox(height: 24),
                  ActionButton(
                    label: 'Update Profile',
                    onPressed: () => _updateProfile(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().updateProfile(
        name: _nameController.text,
        avatar: _image,
      );
    }
  }
}
