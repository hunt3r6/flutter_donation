import 'dart:convert';

import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/model/user_model.dart';

class DonationModel {
  final int? id;
  final String? invoice;
  final int? campaignId;
  final int? donaturId;
  final int? amount;
  final dynamic pray;
  final String? snapToken;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final UserModel? donatur;
  final CampaignModel? campaign;

  DonationModel({
    this.id,
    this.invoice,
    this.campaignId,
    this.donaturId,
    this.amount,
    this.pray,
    this.snapToken,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.donatur,
    this.campaign,
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
    donatur:
        json["donatur"] == null ? null : UserModel.fromMap(json["donatur"]),
    campaign:
        json["campaign"] == null
            ? null
            : CampaignModel.fromMap(json["campaign"]),
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
    "donatur": donatur?.toMap(),
    "campaign": campaign?.toMap(),
  };
}
