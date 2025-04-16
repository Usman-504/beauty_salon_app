import 'package:flutter/material.dart';
import '../../res/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var widthX = MediaQuery.of(context).size.width;
    return  Expanded(
      child: Padding(
        padding: EdgeInsets.all(widthX * 0.04),
        child: const Divider(
          color: AppColors.primaryColor,
          thickness: 2,
        ),
      ),
    );
  }
}