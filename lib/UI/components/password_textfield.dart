import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../screens/User_ui/auth/login_screen/login_provider.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: widthX * 0.04, right: widthX * 0.04, bottom: widthX * 0.04),
      child: TextField(
        obscureText: loginProvider.obscureText,
        controller: controller,
        style: smallTextStyle.copyWith(fontSize: widthX * 0.042),
        decoration: InputDecoration(
            hintText: 'Enter Password',
            suffixIcon: GestureDetector(
                onTap: () {
                  loginProvider.changeVisibility();
                },
                child: Icon(loginProvider.obscureText
                    ? Icons.visibility_off
                    : Icons.visibility)),
            constraints: BoxConstraints(
                maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
            hintStyle: smallTextStyle.copyWith(
                color: Colors.grey, fontSize: widthX * 0.042),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2))),
      ),
    );
  }
}
