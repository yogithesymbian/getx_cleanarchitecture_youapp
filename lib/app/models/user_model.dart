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
  final String? apiToken;
  final String? apiMsg;
  final bool auth;

  const UserModel({
    this.userId,
    super.email,
    super.username,
    this.apiToken,
    this.apiMsg,
    required this.auth,
  });

  UserModel copyWith({
    int? userId,
    String? email,
    String? username,
    String? apiToken,
    String? apiMsg,
    bool? auth,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        username: username ?? this.username,
        apiToken: apiToken ?? this.apiToken,
        apiMsg: apiMsg ?? this.apiMsg,
        auth: auth ?? this.auth,
      );

  factory UserModel.fromJson(JsonMap json) => UserModel(
        userId: json["user_id"],
        email: json["email"],
        username: json["username"],
        apiToken: json["apiToken"],
        apiMsg: json["apiMsg"],
        auth: json["auth"],
      );

  JsonMap toJson() => {
        "user_id": userId,
        "email": email,
        "username": username,
        "apiMsg": apiMsg,
        "auth": auth,
      };
}
