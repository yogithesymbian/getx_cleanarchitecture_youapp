import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/user.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  Future<User> execute(LoginPayload payload) {
    return repository.login(payload);
  }
}
