import 'package:flutter_donation/resource/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLocalResource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Simpan User ke storage
  static Future<void> saveUser(UserModel user) async {
    await _storage.write(key: "user", value: user.toJson());
  }

  /// Ambil User dari storage
  static Future<UserModel?> getUser() async {
    final user = await _storage.read(key: "user");
    return user != null ? UserModel.fromJson(user) : null;
  }

  /// Hapus User dari storage
  static Future<void> deleteUser() async {
    await _storage.delete(key: "user");
  }
}
