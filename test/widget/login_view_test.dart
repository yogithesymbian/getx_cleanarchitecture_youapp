import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/models/user_model.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/usecase/login_usecase.dart';
import 'package:youapp_clean_architecture/app/modules/auth/presentation/controllers/login_controller.dart';
import 'package:youapp_clean_architecture/app/modules/auth/presentation/views/login_view.dart';

class FakeLoginController extends GetxController implements LoginController {
  @override
  RxString email = ''.obs;

  @override
  RxString password = ''.obs;

  @override
  RxString username = ''.obs;

  @override
  GlobalKey<FormState> get formKey => GlobalKey<FormState>();

  @override
  RxBool get hidePassword => true.obs;

  @override
  RxBool get loading => false.obs;

  @override
  Future<void> login() {
    throw UnimplementedError();
  }

  @override
  LoginUsecase get loginUsecase => throw UnimplementedError();

  @override
  Rx<UserModel> get user => UserModel(auth: false).obs;

  @override
  bool isFilled() {
    throw UnimplementedError();
  }

  @override
  Future<void> filledTextFieldFromRegisterIfExist() {
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('render LoginView with form Fields', (tester) async {
    Get.put<LoginController>(FakeLoginController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: LoginView(),
      ),
    );

    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Login'), findsOneWidget);
  });
}
