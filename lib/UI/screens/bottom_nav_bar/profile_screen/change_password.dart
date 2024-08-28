import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../generated/assets.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButtonColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('Change Password',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: heightX * 0.03)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(hintText: 'Old Password', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          CustomTextField(hintText: 'New Password', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          CustomTextField(hintText: 'Confirm New Password', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          CustomButton(height: heightX * 0.06, width: widthX * 0.9, text: 'Save', borderRadius: 10, onPress: (){}, style: mediumTextStyle)
        ],
      ),
    );
  }
}