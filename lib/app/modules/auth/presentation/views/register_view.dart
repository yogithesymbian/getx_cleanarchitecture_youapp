import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/global_widgets/block_button_widget.dart';
import 'package:youapp_clean_architecture/app/global_widgets/text_field_widget.dart';
import 'package:youapp_clean_architecture/app/modules/auth/presentation/controllers/register_controller.dart';
import 'package:youapp_clean_architecture/common/colors.dart';
import 'package:youapp_clean_architecture/common/theme.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Get.theme.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "Register",
                    style: Get.textTheme.titleLarge,
                  ),
                ),
                TextFieldWidget(
                  key: const Key('emailField'),
                  labelText: "Email",
                  hintText: "Enter Email",
                  onChanged: (input) => controller.email.value = input,
                  onSaved: (input) => controller.email.value = input ?? '',
                  validator: (input) => input!.isEmpty
                      ? "Field cannot be empty"
                      : GetUtils.isEmail(input.trim())
                          ? null
                          : 'Enter Valid Email',
                  keyboardType: TextInputType.emailAddress,
                ).marginOnly(bottom: 4),
                TextFieldWidget(
                  key: const Key('usernameField'),
                  labelText: "Username",
                  hintText: "Create Username",
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
                    hintText: "Create Password",
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
                        color: AppColors.linkTextColor.color,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TextFieldWidget(
                    key: const Key('passwordConfirmField'),
                    labelText: "Password",
                    hintText: "Confirm Password",
                    onSaved: (input) =>
                        controller.passwordConfirm.value = input ?? '',
                    onChanged: (input) =>
                        controller.passwordConfirm.value = input,
                    validator: (input) => input!.isEmpty
                        ? "Field cannot be empty"
                        : input.length < 3
                            ? "You must enter 3 character least"
                            : input != controller.password.value
                                ? "Confirm Password not match"
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
                        color: AppColors.linkTextColor.color,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => BlockButtonWidget(
                    color: AppColors.bgColor.color,
                    text: Text(
                      'Register',
                      style: Get.textTheme.headlineMedium!.copyWith(
                        color: AppColors.white.color.withValues(alpha: 0.8),
                        fontSize: 16,
                      ),
                    ),
                    onPressed:
                        controller.isFilled() ? controller.register : null,
                    verticalPadding: 14,
                    width: double.infinity,
                  ).marginOnly(top: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account ? ',
                      style: Get.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => controller.toLogin(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Login here',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.linkTextColor.color,
                          decorationColor: AppColors.linkTextColor.color,
                        ),
                      ),
                    ),
                  ],
                ).marginOnly(top: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
