// To parse this JSON data, do
//
//     final loginResultDto = loginResultDtoFromJson(jsonString);

import 'dart:convert';

LoginResultDto loginResultDtoFromJson(String str) =>
    LoginResultDto.fromJson(json.decode(str));

String loginResultDtoToJson(LoginResultDto data) => json.encode(data.toJson());

class LoginResultDto {
  String message;
  String accessToken;

  LoginResultDto({
    required this.message,
    required this.accessToken,
  });

  factory LoginResultDto.fromJson(Map<String, dynamic> json) => LoginResultDto(
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "access_token": accessToken,
      };
}
