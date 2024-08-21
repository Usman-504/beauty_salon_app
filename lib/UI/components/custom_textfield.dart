
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';

import '../../core/constants/const_colors.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final double maxWidth;
  final double maxHeight;
  final Widget? prefix;

  const CustomTextField({
    required this.hintText,
    required this.maxWidth,
    required this.maxHeight,
   this.prefix,
    super.key,
  });



  @override
  Widget build(BuildContext context) {

    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: widthX * 0.04),
      child: TextField(
        style: smallTextStyle.copyWith(fontSize: heightX * 0.02),
        decoration: InputDecoration(
            hintText: hintText,
          prefixIcon: prefix,
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            hintStyle: smallTextStyle.copyWith(color: Colors.grey, fontSize: heightX * 0.02),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: kButtonColor, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: kButtonColor, width: 2))),
      ),
    );
  }
}