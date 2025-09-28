import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/models/user_model.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/login_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/usecase/login_usecase.dart';
import 'package:youapp_clean_architecture/app/routes/app_routes.dart';
import 'package:youapp_clean_architecture/app/services/background/user_service.dart';

class LoginController extends GetxController {
  final LoginUsecase loginUsecase;
  LoginController(this.loginUsecase);
  final loading = false.obs;
  final Rx<UserModel> user = Get.find<UserService>().user;
  final hidePassword = true.obs;
  final formKey = GlobalKey<FormState>();

  RxString email = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit() async {
    await filledTextFieldFromRegisterIfExist();
    super.onInit();
  }

  /*
  * User Experience After Register
  * automatic filled for email and username  */
  Future<void> filledTextFieldFromRegisterIfExist() async {
    final emailFromInit = user.value.email ?? '';
    final usernameFromInit = user.value.username ?? '';

    email.value = emailFromInit;
    username.value = usernameFromInit;
  }

  Future<void> login() async {
    Get.focusScope?.unfocus();
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    loading.value = true;
    try {
      final result = await loginUsecase.execute(
        LoginPayload(
          email: email.value,
          username: username.value,
          password: password.value,
        ),
      );
      if (result is UserModel) {
        user.value = result;
      }

      Get.snackbar("Success", 'Welcome ${result.username}');
      Get.offAllNamed(Routes.ROOT);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  bool isFilled() {
    return email.value.isNotEmpty &&
            username.value.isNotEmpty &&
            password.value.isNotEmpty
        ? true
        : false;
  }
}
