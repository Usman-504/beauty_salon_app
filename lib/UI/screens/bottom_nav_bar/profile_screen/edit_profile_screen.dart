import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../generated/assets.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
        title: Text('Update Profile',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: heightX * 0.03)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
           children: [
             Container(
               height: heightX * 0.25,
             ),
             Positioned(
               top: heightX * 0.03,
               left: widthX * 0.3,
               child: Container(
                 height: heightX * 0.18,
                 width: heightX * 0.18,
                 decoration: BoxDecoration(
                     border: Border.all(color: kButtonColor, width: 3),
                     shape: BoxShape.circle),
               ),
             ),
             Positioned(
               top: heightX * 0.04,
               left: widthX * 0.32,
               child: Container(
                 height: heightX * 0.16,
                 width: heightX * 0.16,
                 decoration: const BoxDecoration(
                     image: DecorationImage(image: AssetImage(Assets.dp)),
                     shape: BoxShape.circle),
               ),
             ),
             Positioned(
               top: heightX * 0.15,
               left: widthX * 0.55,
               child: Container(
                 height: heightX * 0.05,
                 width: heightX * 0.05,
                 decoration: const BoxDecoration(
                   color: kCircleAvatorColor,
                   shape: BoxShape.circle,
                 ),
                 child: Icon(Icons.camera_alt, color: Colors.white,),
               ),
             ),
           ],
          ),
          CustomTextField(hintText: 'Update Name', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          CustomTextField(hintText: 'Update Email', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          CustomTextField(hintText: 'Update phone No', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08),
          CustomButton(height: heightX * 0.06, width: widthX * 0.9, text: 'Save', borderRadius: 10, onPress: (){}, style: mediumTextStyle, btnColor: kButtonColor,)
        ],
      ),
    );
  }
}
