// To parse this JSON data, do
//
//     final registerResultDto = registerResultDtoFromJson(jsonString);

import 'dart:convert';

RegisterResultDto registerResultDtoFromJson(String str) =>
    RegisterResultDto.fromJson(json.decode(str));

String registerResultDtoToJson(RegisterResultDto data) =>
    json.encode(data.toJson());

class RegisterResultDto {
  String message;

  RegisterResultDto({
    required this.message,
  });

  factory RegisterResultDto.fromJson(Map<String, dynamic> json) =>
      RegisterResultDto(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
