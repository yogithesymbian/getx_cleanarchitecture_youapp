import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/global_widgets/block_button_widget.dart';
import 'package:youapp_clean_architecture/app/global_widgets/text_field_widget.dart';
import 'package:youapp_clean_architecture/common/colors.dart';
import 'package:youapp_clean_architecture/common/theme.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Get.theme.backgroundGradient,
        ),
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Login',
                    style: Get.textTheme.titleLarge,
                  ),
                ).marginOnly(bottom: 12.0),
                TextFieldWidget(
                  key: const Key('emailField'),
                  labelText: "Email",
                  hintText: "Enter Email",
                  onChanged: (input) => controller.email.value = input,
                  onSaved: (input) => controller.email.value = input ?? '',
                  keyboardType: TextInputType.emailAddress,
                  // GetUtils.isEmail(emailOrUsername.value.trim())
                ).marginOnly(bottom: 4),
                TextFieldWidget(
                  key: const Key('usernameField'),
                  labelText: "Username",
                  hintText: "Enter Username",
                  onChanged: (input) => controller.username.value = input,
                  onSaved: (input) => controller.username.value = input ?? '',
                  validator: (input) =>
                      input!.isEmpty ? "Field cannot be empty" : null,
                  keyboardType: TextInputType.name,
                ).marginOnly(bottom: 4),
                Obx(
                  () => TextFieldWidget(
                    key: const Key('passwordField'),
                    labelText: "Password",
                    hintText: "*****",
                    onSaved: (input) => controller.password.value = input ?? '',
                    onChanged: (input) => controller.password.value = input,
                    validator: (input) => input!.isEmpty
                        ? "Field cannot be empty"
                        : input.length < 3
                            ? "You must enter 3 character least"
                            : null,
                    obscureText: controller.hidePassword.value,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: GestureDetector(
                      onTap: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      child: Icon(
                        controller.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.white.color,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => BlockButtonWidget(
                    color: AppColors.bgColor.color,
                    text: Text(
                      'Login',
                      style: Get.textTheme.headlineMedium!.copyWith(
                        color: AppColors.white.color.withValues(alpha: 0.5),
                        fontSize: 16,
                      ),
                    ),
                    onPressed: controller.isFilled() ? controller.login : null,
                    verticalPadding: 14,
                    width: double.infinity,
                  ).marginOnly(top: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Account ? ',
                      style: Get.textTheme.bodyMedium,
                    ),
                    Text(
                      'Register here',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.white.color,
                      ),
                    ),
                  ],
                ).marginOnly(top: 48)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
