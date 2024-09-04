import 'package:flutter/material.dart';

import '../../core/constants/const_colors.dart';

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
          color: kPrimaryColor,
          thickness: 2,
        ),
      ),
    );
  }
}