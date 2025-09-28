import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_clean_architecture/app/models/user_model.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/usecase/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class LoginPayloadFake extends Fake implements LoginPayload {}

void main() {
  late LoginUsecase loginUsecase;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    registerFallbackValue(LoginPayloadFake());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUsecase = LoginUsecase(mockAuthRepository);
  });

  test('should return User or ApiToken when login succeeds', () async {
    final tLoginPayload = LoginPayload(
      email: 'yogi@yogiveloper.com',
      username: 'yogiveloper',
      password: 'password',
    );
    final tUserModel = UserModel(
      auth: true,
      email: tLoginPayload.email,
      username: tLoginPayload.username,
    );

    when(
      () => mockAuthRepository.login(any()),
    ).thenAnswer(
      (_) async => tUserModel,
    );

    final result = await loginUsecase.execute(tLoginPayload);
    expect(result, isA<UserModel>());
    expect((result as UserModel).auth, tUserModel.auth);
    verify(() => mockAuthRepository.login(tLoginPayload)).called(1);
  });
}
