import 'package:flutter/material.dart';
import '../res/colors.dart';

var primaryTextStyle = const TextStyle(
    color: AppColors.whiteColor,
    fontSize:  30,
    fontWeight: FontWeight.bold,
);

var secondaryTextStyle =  const TextStyle(
    color: AppColors.whiteColor,
    fontSize:  24,
    fontWeight: FontWeight.bold);


var mediumTextStyle =  const TextStyle(
    color: AppColors.whiteColor,
    fontSize:  18,
    fontWeight: FontWeight.bold);

var smallTextStyle =  const TextStyle(
    color: AppColors.primaryColor,
    fontSize:  15,
    fontWeight: FontWeight.bold);

var boxShadow = const [BoxShadow(
  color: Colors.black,
  blurRadius: 9,
  spreadRadius: 5,
  blurStyle: BlurStyle.outer,
)];