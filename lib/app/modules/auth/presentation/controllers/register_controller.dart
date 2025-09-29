import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/exceptions/network_exceptions.dart';
import 'package:youapp_clean_architecture/app/models/user_model.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/payload/register_payload.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/usecase/register_usecase.dart';
import 'package:youapp_clean_architecture/app/routes/app_routes.dart';
import 'package:youapp_clean_architecture/app/services/background/user_service.dart';

class RegisterController extends GetxController {
  final RegisterUsecase registerUsecase;
  RegisterController(this.registerUsecase);
  final loading = false.obs;
  final Rx<UserModel> user = Get.find<UserService>().user;
  final hidePassword = true.obs;
  final formKey = GlobalKey<FormState>();

  RxString email = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxString passwordConfirm = ''.obs;

  Future<void> register() async {
    Get.focusScope?.unfocus();
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    loading.value = true;
    try {
      final result = await registerUsecase.execute(
        RegisterPayload(
          email: email.value,
          username: username.value,
          password: password.value,
        ),
      );
      if (result is UserModel) {
        user.value = result;
      }

      Get.snackbar("Success", "Registered");
      // Get.offNamed(Routes.LOGIN);
    } on ErrorEntity catch (e) {
      Get.snackbar("Error Entity", e.message);
    } catch (e) {
      Get.snackbar("Error Catch", e.toString());
    } finally {
      loading.value = false;
    }
  }

  bool isFilled() {
    return email.value.isNotEmpty &&
            username.value.isNotEmpty &&
            password.value.isNotEmpty &&
            passwordConfirm.value.isNotEmpty
        ? true
        : false;
  }

  Future<void> toLogin() async {
    Get.toNamed(Routes.LOGIN);
  }
}
