import 'package:youapp_clean_architecture/app/exceptions/network_exceptions.dart';
import 'package:youapp_clean_architecture/app/models/user_model.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/register_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/auth_message.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/user.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> login(LoginPayload payload) async {
    try {
      final model = await remoteDatasource.login(payload);
      return UserModel(
        auth: true,
        userId: 1, // todo: backend request need user id
        apiToken: model.accessToken,
        email: payload.email,
        username: payload.username,
      );
    } on ErrorEntity catch (_) {
      // rethrow handle by controller for catch
      rethrow;
    }
  }

  @override
  Future<User> register(RegisterPayload payload) async {
    try {
      final model = await remoteDatasource.register(payload);
      final apiMsg = model.message;
      final state = AuthMessage.fromString(apiMsg);

      if (AuthMessage.userCreated == state) {
        return UserModel(
          auth: false,
          email: payload.email,
          username: payload.username,
        ).copyWith(apiMsg: apiMsg);
      }
      if (AuthMessage.userExists == state) {
        return const UserModel(auth: false).copyWith(apiMsg: apiMsg);
      }
      return const UserModel(auth: false);
    } on ErrorEntity catch (_) {
      // rethrow handle by controller for catch
      rethrow;
    }
  }
}
