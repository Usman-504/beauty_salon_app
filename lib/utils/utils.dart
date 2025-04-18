import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../res/colors.dart';


class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          icon: const Icon(
            Icons.check_circle,
            color: AppColors.whiteColor,
            size: 25,
          ),
          backgroundColor: AppColors.primaryColor,
          messageColor: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          duration: const Duration(seconds: 3),
          message: message,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
        )..show(context));
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 25,
          ),
          backgroundColor: AppColors.primaryColor,
          messageColor: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          duration: const Duration(seconds: 3),
          message: message,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: AppColors.whiteColor),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    ));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode? next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }










}


