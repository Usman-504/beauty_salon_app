import 'dart:async';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../generated/assets.dart';
import '../User_ui/auth/auth_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthCheck authCheck = AuthCheck();

  User? user = FirebaseAuth.instance.currentUser ;
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), (){
      user != null ?
      authCheck.checkUserRole(context) : authCheck.signInUser(context) ;
    });
  }

@override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
          ),
          Positioned(
            left: widthX * 0.3,
              top: heightX * 0.48,
              child: Image.asset(Assets.logo, color: kPrimaryColor,)),
          Positioned(
              left: widthX * 0.47,
              top: heightX * 0.53,
              child: Image.asset(Assets.beautilly, )),
        ],
      ),
    );
  }
}