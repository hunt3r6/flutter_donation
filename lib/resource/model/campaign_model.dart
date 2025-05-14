// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_donation/resource/model/user_model.dart';

class CampaignModel {
  final int? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? image;
  final String? targetDonation;
  final DateTime? maxDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;

  CampaignModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.targetDonation,
    this.maxDate,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  CampaignModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? description,
    String? image,
    String? targetDonation,
    DateTime? maxDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      image: image ?? this.image,
      targetDonation: targetDonation ?? this.targetDonation,
      maxDate: maxDate ?? this.maxDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'image': image,
      'targetDonation': targetDonation,
      'maxDate': maxDate?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'user': user?.toMap(),
    };
  }

  factory CampaignModel.fromMap(Map<String, dynamic> map) {
    return CampaignModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      targetDonation:
          map['targetDonation'] != null
              ? map['targetDonation'] as String
              : null,
      maxDate:
          map['maxDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['maxDate'] as int)
              : null,
      createdAt:
          map['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : null,
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : null,
      user:
          map['user'] != null
              ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CampaignModel.fromJson(String source) =>
      CampaignModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CampaignModel(id: $id, title: $title, slug: $slug, description: $description, image: $image, targetDonation: $targetDonation, maxDate: $maxDate, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(covariant CampaignModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.slug == slug &&
        other.description == description &&
        other.image == image &&
        other.targetDonation == targetDonation &&
        other.maxDate == maxDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        slug.hashCode ^
        description.hashCode ^
        image.hashCode ^
        targetDonation.hashCode ^
        maxDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        user.hashCode;
  }
}
