import 'package:beauty_salon/UI/screens/User_ui/auth/signup_screen/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../admin-ui/bottom_nav_bar/admin_bottom_nav_bar.dart';
import '../bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'login_screen/login_screen.dart';

class AuthCheck  {
  void checkUserRoleAndNavigate(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

      String role = userDoc.get('role');

      if (role == 'admin') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminBottomNavBar()));
      }
      else if (role == 'client'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

void checkUserRole(BuildContext context)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? role = sp.getString('role');

    if (role == 'admin') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminBottomNavBar()));
    }
    else if (role == 'client'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
    }
}


void signInUser(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
}


}
