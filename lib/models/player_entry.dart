// To parse this JSON data, do
//
//     final playerEntry = playerEntryFromJson(jsonString);

import 'dart:convert';

PlayerEntry playerEntryFromJson(String str) => PlayerEntry.fromJson(json.decode(str));

String playerEntryToJson(PlayerEntry data) => json.encode(data.toJson());

class PlayerEntry {
  String id;
  String name;
  int price;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  String club;
  String nationality;
  double height;
  int userId;
  String userUsername;

  PlayerEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.club,
    required this.nationality,
    required this.height,
    required this.userId,
    required this.userUsername,
  });

  factory PlayerEntry.fromJson(Map<String, dynamic> json) => PlayerEntry(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        price: json["price"] ?? 0,
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        category: json["category"] ?? "",
        isFeatured: json["is_featured"] ?? false,
        club: json["club"] ?? "",
        nationality: json["nationality"] ?? "",
        height: (json["height"] as num?)?.toDouble() ?? 0.0,
        userId: json["user_id"] ?? 0,
        userUsername: json["user_username"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "club": club,
        "nationality": nationality,
        "height": height,
        "user_id": userId,
        "user_username": userUsername,
      };
}
