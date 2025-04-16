import 'dart:async';
import 'package:flutter/material.dart';
import '../../../res/colors.dart';
import '../../../utils/assets.dart';
import '../User_ui/auth/auth_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthCheck authCheck = AuthCheck();


  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), (){

      authCheck.checkUserRole(context);
    });
  }

@override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
          ),
          Positioned(
            left: widthX * 0.3,
              top: heightX * 0.48,
              child: Image.asset(Assets.logo, color: AppColors.primaryColor,)),
          Positioned(
              left: widthX * 0.47,
              top: heightX * 0.53,
              child: Image.asset(Assets.beautilly, )),
        ],
      ),
    );
  }
}