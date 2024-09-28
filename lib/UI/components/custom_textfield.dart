
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';

import '../../core/constants/const_colors.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final double maxWidth;
  final double maxHeight;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomTextField({
    required this.hintText,
    required this.maxWidth,
    required this.maxHeight,
    this.maxLines,
    this.keyBoardType,
     this.controller,
    this.onChanged,
   this.prefix,
   this.suffix,
    super.key,
  });



  @override
  Widget build(BuildContext context) {

    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: widthX * 0.04),
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLines,
        keyboardType: keyBoardType,
        controller: controller,
        style: smallTextStyle.copyWith(fontSize: widthX * 0.042),
        decoration: InputDecoration(
            hintText: hintText,
          prefixIcon: prefix,
            suffixIcon: suffix,
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            hintStyle: smallTextStyle.copyWith(color: Colors.grey, fontSize: widthX * 0.042),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: kPrimaryColor, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: kPrimaryColor, width: 2))),
      ),
    );
  }
}