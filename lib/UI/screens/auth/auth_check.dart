import 'package:beauty_salon/UI/screens/auth/login_screen/login_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin-ui/admin_bottom_nav_bar.dart';

class AuthCheck  {
  void checkUserRoleAndNavigate(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

      String role = userDoc.get('role');

      if (role == 'admin') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminBottomNavBar()));
      } else if (role == 'client'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }




}
