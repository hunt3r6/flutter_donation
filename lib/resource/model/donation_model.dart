import 'dart:convert';

class DonationModel {
  final int id;
  final String invoice;
  final int campaignId;
  final int donaturId;
  final int amount;
  final dynamic pray;
  final String snapToken;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Campaign campaign;

  DonationModel({
    required this.id,
    required this.invoice,
    required this.campaignId,
    required this.donaturId,
    required this.amount,
    required this.pray,
    required this.snapToken,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.campaign,
  });

  factory DonationModel.fromJson(String str) =>
      DonationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DonationModel.fromMap(Map<String, dynamic> json) => DonationModel(
    id: json["id"],
    invoice: json["invoice"],
    campaignId: json["campaign_id"],
    donaturId: json["donatur_id"],
    amount: json["amount"],
    pray: json["pray"],
    snapToken: json["snap_token"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    campaign: Campaign.fromMap(json["campaign"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "invoice": invoice,
    "campaign_id": campaignId,
    "donatur_id": donaturId,
    "amount": amount,
    "pray": pray,
    "snap_token": snapToken,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "campaign": campaign.toMap(),
  };
}

class Campaign {
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

  Campaign({
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
  });

  factory Campaign.fromJson(String str) => Campaign.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Campaign.fromMap(Map<String, dynamic> json) => Campaign(
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
  );

  Map<String, dynamic> toMap() => {
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
  };
}
