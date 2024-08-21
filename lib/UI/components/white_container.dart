import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;

  const WhiteContainer({
    required this.height,
    required this.width,
    required this.child , super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
