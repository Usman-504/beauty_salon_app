import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import '../../core/constants/const_colors.dart';

class SocialContainer extends StatelessWidget {
  const SocialContainer({
    super.key,

    required this.imageUrl,
    required this.text,
    required this.height,
    required this.onPress,
  });


  final String text;
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
        width: widthX * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: kButtonColor, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, height:height),
            SizedBox(
              width: widthX * 0.02,
            ),
            Text(text, style: mediumTextStyle.copyWith(fontSize: heightX*0.024, color: kButtonColor),)
            //H2(text: text, color: kButtonColor),
          ],
        ),
      ),
    );
  }
}