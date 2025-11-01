import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ToastMessage {
  static void toastSuccess(BuildContext context, String text) {
    MotionToast.success(
      title: CustomText(text: 'Success', color: AppColor.blackColor),
      description: CustomText(text: text, color: AppColor.blackColor),
      animationDuration: Duration(milliseconds: 400),
    ).show(context);
  }

  static void toastError(BuildContext context, String text) {
    MotionToast.error(
      title: CustomText(text: 'Error', color: AppColor.blackColor),
      description: CustomText(text: text, color: AppColor.blackColor),
      animationDuration: Duration(milliseconds: 400),
    ).show(context);
  }
}
