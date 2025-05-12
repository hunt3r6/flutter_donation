import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalResource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Simpan token ke storage
  static Future<void> saveToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  /// Ambil token dari storage
  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  /// Hapus token dari storage
  static Future<void> deleteToken() async {
    await _storage.delete(key: "token");
  }
}
