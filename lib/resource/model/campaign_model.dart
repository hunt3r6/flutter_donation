import 'dart:convert';

class CampaignModel {
  final int id;
  final String title;
  final String slug;
  final int categoryId;
  final int targetDonation;
  final DateTime maxDate;
  final String description;
  final String image;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final List<SumDonation> sumDonation;

  CampaignModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryId,
    required this.targetDonation,
    required this.maxDate,
    required this.description,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.sumDonation,
  });

  factory CampaignModel.fromRawJson(String str) =>
      CampaignModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CampaignModel.fromJson(Map<String, dynamic> json) => CampaignModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryId: json["category_id"],
    targetDonation: json["target_donation"],
    maxDate: DateTime.parse(json["max_date"]),
    description: json["description"],
    image: json["image"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
    sumDonation: List<SumDonation>.from(
      json["sum_donation"].map((x) => SumDonation.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_id": categoryId,
    "target_donation": targetDonation,
    "max_date":
        "${maxDate.year.toString().padLeft(4, '0')}-${maxDate.month.toString().padLeft(2, '0')}-${maxDate.day.toString().padLeft(2, '0')}",
    "description": description,
    "image": image,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
    "sum_donation": List<dynamic>.from(sumDonation.map((x) => x.toJson())),
  };
}

class SumDonation {
  final int campaignId;
  final String total;

  SumDonation({required this.campaignId, required this.total});

  factory SumDonation.fromRawJson(String str) =>
      SumDonation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SumDonation.fromJson(Map<String, dynamic> json) =>
      SumDonation(campaignId: json["campaign_id"], total: json["total"]);

  Map<String, dynamic> toJson() => {"campaign_id": campaignId, "total": total};
}

class User {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final String avatar;
  final dynamic createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    avatar: json["avatar"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "avatar": avatar,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}
