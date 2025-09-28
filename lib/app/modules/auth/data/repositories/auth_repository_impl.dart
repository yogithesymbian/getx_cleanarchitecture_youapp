import 'package:youapp_clean_architecture/app/models/user_model.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/register_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/user.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> login(LoginPayload payload) async {
    final model = await remoteDatasource.login(payload);
    return UserModel(
      auth: true,
      userId: 1, // backend request need user id
      apiToken: model.accessToken,
      email: payload.email,
      username: payload.username,
    );
  }

  @override
  Future<User> register(RegisterPayload payload) async {
    final model = await remoteDatasource.register(payload);
    if (model.message != 'User has been created successfully') {
      return const UserModel(auth: false);
    }

    return UserModel(
      auth: false,
      email: payload.email,
      username: payload.username,
    );
  }
}
