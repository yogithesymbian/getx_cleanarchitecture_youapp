import 'package:dio/dio.dart';
import 'package:youapp_clean_architecture/app/exceptions/network_exceptions.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/dto/register_result_dto.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/register_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/dto/login_result_dto.dart';
import 'package:youapp_clean_architecture/app/providers/dio_client.dart';
import 'package:youapp_clean_architecture/common/api_message.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResultDto> login(LoginPayload payload);
  Future<RegisterResultDto> register(RegisterPayload payload);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final DioClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<LoginResultDto> login(LoginPayload payload) async {
    try {
      final response = await client.post('login', data: payload.toJson());
      return LoginResultDto.fromJson(response);
    } on DioException catch (e) {
      final msg = e.error?.toString() ?? ApiMessage.unknown.toString();
      throw ErrorEntity(code: e.response?.statusCode ?? -1, message: msg);
    }
  }

  @override
  Future<RegisterResultDto> register(RegisterPayload payload) async {
    try {
      final response = await client.post('register', data: payload.toJson());
      return RegisterResultDto.fromJson(response);
    } on DioException catch (e) {
      final msg = e.error?.toString() ?? ApiMessage.unknown.toString();
      throw ErrorEntity(code: e.response?.statusCode ?? 1, message: msg);
    }
  }
}
