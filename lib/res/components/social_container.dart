import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../res/colors.dart';

class SocialContainer extends StatelessWidget {
  const SocialContainer({
    super.key,

    required this.imageUrl,
    required this.text,
    required this.height,
    required this.width,
    required this.onPress,
  });


  final String text;
  final double width;
  final String imageUrl;
  final double height;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height:heightX * 0.06,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, height:height),
            SizedBox(
              width: widthX * 0.02,
            ),
            Text(text, style: mediumTextStyle.copyWith(fontSize: widthX*0.05, color: AppColors.primaryColor),)
            //H2(text: text, color: kButtonColor),
          ],
        ),
      ),
    );
  }
}