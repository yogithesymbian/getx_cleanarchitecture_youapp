// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:artools/artools.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  final int? userId;
  @override
  final String? email;
  @override
  final String? username;
  final String? apiToken;
  bool auth;

  UserModel({
    this.userId,
    this.email,
    this.username,
    this.apiToken,
    required this.auth,
  });

  UserModel copyWith({
    int? userId,
    String? email,
    String? username,
    String? apiToken,
    bool? auth,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        username: username ?? this.username,
        apiToken: apiToken ?? this.apiToken,
        auth: auth ?? this.auth,
      );

  factory UserModel.fromJson(JsonMap json) => UserModel(
        userId: json["user_id"],
        email: json["email"],
        username: json["username"],
        apiToken: json["apiToken"],
        auth: json["auth"],
      );

  JsonMap toJson() => {
        "user_id": userId,
        "email": email,
        "username": username,
        "apiToken": apiToken,
        "auth": auth,
      };
}
