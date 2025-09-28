import 'package:dio/dio.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/dto/register_result_dto.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/register_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/dto/login_result_dto.dart';
import 'package:youapp_clean_architecture/app/providers/dio_client.dart';

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
      throw Exception(e.message);
    }
  }

  @override
  Future<RegisterResultDto> register(RegisterPayload payload) async {
    try {
      final response = await client.post('register', data: payload.toJson());
      return RegisterResultDto.fromJson(response['response']);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
