import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/register_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(LoginPayload payload);
  Future<User> register(RegisterPayload paylad);
}
