import 'dart:convert';

import 'package:flutter_donation/resource/model/user_model.dart';

class CampaignModel {
  final int? id;
  final String? title;
  final String? slug;
  final int? categoryId;
  final int? targetDonation;
  final DateTime? maxDate;
  final String? description;
  final String? image;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final UserModel? user;
  final List<SumDonation>? sumDonation;

  CampaignModel({
    this.id,
    this.title,
    this.slug,
    this.categoryId,
    this.targetDonation,
    this.maxDate,
    this.description,
    this.image,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.sumDonation,
  });

  factory CampaignModel.fromJson(String str) =>
      CampaignModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CampaignModel.fromMap(Map<String, dynamic> json) => CampaignModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryId: json["category_id"],
    targetDonation: json["target_donation"],
    maxDate:
        json["max_date"] != null ? DateTime.tryParse(json["max_date"]) : null,
    description: json["description"],
    image: json["image"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user: json["user"] != null ? UserModel.fromMap(json["user"]) : null,
    sumDonation:
        json["sum_donation"] != null
            ? List<SumDonation>.from(
              json["sum_donation"].map((x) => SumDonation.fromMap(x)),
            )
            : [],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_id": categoryId,
    "target_donation": targetDonation,
    "max_date":
        maxDate != null
            ? "${maxDate!.year.toString().padLeft(4, '0')}-${maxDate!.month.toString().padLeft(2, '0')}-${maxDate!.day.toString().padLeft(2, '0')}"
            : null,
    "description": description,
    "image": image,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toMap(),
    "sum_donation":
        sumDonation != null
            ? List<dynamic>.from(sumDonation!.map((x) => x.toMap()))
            : [],
  };
}

class SumDonation {
  final int? campaignId;
  final String? total;

  SumDonation({this.campaignId, this.total});

  factory SumDonation.fromJson(String str) =>
      SumDonation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SumDonation.fromMap(Map<String, dynamic> json) =>
      SumDonation(campaignId: json["campaign_id"], total: json["total"]);

  Map<String, dynamic> toMap() => {"campaign_id": campaignId, "total": total};
}
