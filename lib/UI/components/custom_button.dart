import 'package:flutter/material.dart';

import '../../core/constants/const_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.borderRadius,
    required this.onPress,
    required this.style,
    required this.btnColor,
    this.loading = false,
  });

  final double height;
  final double width;
  final String text;
  final TextStyle style;
  final double borderRadius;
  final VoidCallback onPress;
  final Color btnColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child:  Center(
      child: loading ? const Center(child: CircularProgressIndicator(color: kWhiteColor,)) :  Text(text, style: style),
            //child: H2(text: text, color: kWhiteColor)),
      )),
    );
  }
}