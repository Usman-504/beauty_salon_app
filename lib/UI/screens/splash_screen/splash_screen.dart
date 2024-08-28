import 'dart:async';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:flutter/material.dart';
import '../../../generated/assets.dart';
import '../auth/auth_check.dart';

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
      authCheck.checkUserRoleAndNavigate(context);
    });
  }

  // void checkUserRoleAndNavigate() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
  //
  //     String role = userDoc.get('role');
  //
  //     if (role == 'admin') {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminBottomNavBar()));
  //     } else {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
  //     }
  //   } else {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  //   }
  // }

@override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kCircleAvatorColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
          ),
          Positioned(
            left: widthX * 0.3,
              top: heightX * 0.48,
              child: Image.asset(Assets.logo, color: kButtonColor,)),
          Positioned(
              left: widthX * 0.47,
              top: heightX * 0.53,
              child: Image.asset(Assets.beautilly, )),
        ],
      ),
    );
  }
}
