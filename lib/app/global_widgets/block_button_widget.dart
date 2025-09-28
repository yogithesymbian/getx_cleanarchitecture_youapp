import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_clean_architecture/common/colors.dart';
import 'package:youapp_clean_architecture/common/theme.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
    this.width,
    this.horizontalMargin,
    required this.verticalPadding,
  });

  final Color color;
  final Widget text;
  final onPressed;
  final double? width;
  final double verticalPadding;
  final double? horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? double.infinity,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 24),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.color.withValues(alpha: 0.5),
              blurStyle: BlurStyle.normal,
              blurRadius: 50,
              spreadRadius: 1.0,
              offset: const Offset(0, 20),
            ),
          ],
          gradient: Get.theme.backgroundGradientLinear,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          // color: color,
          disabledElevation: 0,
          disabledTextColor: AppColors.white.color.withOpacity(0.2),
          disabledColor: Get.theme.disabledColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          child: text,
        ));
  }
}
