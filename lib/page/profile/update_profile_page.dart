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
  bool _isUpdating = false; // To track update status
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
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
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              // Assuming ProfileCubit has a ProfileUpdating state
              if (state is ProfileUpdating) {
                setState(() {
                  _isUpdating = true;
                });
              } else if (state is ProfileUpdated) {
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
              } else if (state is ProfileLoaded) {
                // Ini untuk pemuatan data awal, _isUpdating tidak boleh terpengaruh di sini
                // kecuali ProfileLoaded juga menandakan akhir dari update (kemungkinan kecil).
                setState(() {
                  user = state.user;
                  _nameController.text = user.name ?? '';
                  _emailController.text = user.email ?? '';
                });
              }
            },
            builder: (context, state) {
              // Bungkus Form dengan Stack untuk menampilkan overlay loading
              return Form(
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
                                    // Gunakan user.avatar dari state page, bukan dari state BLoC secara langsung di sini
                                    // agar gambar tetap tampil selama state BLoC berubah (misal ke ProfileUpdating)
                                    imageUrl: user.avatar ?? '',
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
                            // Nonaktifkan tap jika sedang update
                            onTap:
                                _isUpdating
                                    ? null
                                    : () async {
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
                      enabled: false, // Email field tidak bisa diubah
                      controller: _emailController,
                      hintText: 'Alamat Email',
                      prefixIcon: CupertinoIcons.mail,
                    ),
                    const SizedBox(height: 24),
                    ActionButton(
                      label:
                          _isUpdating
                              ? 'Sedang Memproses...'
                              : 'Update Profile',
                      // Nonaktifkan tombol jika sedang update
                      onPressed: _isUpdating ? null : () => _updateProfile(),
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

  void _updateProfile() {
    // Cegah pemanggilan berulang jika sedang dalam proses update
    if (_isUpdating) return;

    if (_formKey.currentState?.validate() ?? false) {
      // Cubit harusnya memancarkan state ProfileUpdating
      context.read<ProfileCubit>().updateProfile(
        name: _nameController.text,
        avatar: _image,
      );
    }
  }
}
