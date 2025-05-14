// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? emailVerifiedAt,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'avatar': avatar,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      emailVerifiedAt:
          map['emailVerifiedAt'] != null
              ? map['emailVerifiedAt'] as String
              : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      createdAt:
          map['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : null,
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, avatar: $avatar, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        emailVerifiedAt.hashCode ^
        avatar.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
