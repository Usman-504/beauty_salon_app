import 'package:beauty_salon/view/salon_owner_view/salon_owner_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view/user_view/bottom_nav_bar.dart';
import '../../view/user_view/login_view.dart';

class AuthCheck  {
  void checkUserRoleAndNavigate(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

      String role = userDoc.get('role');

      if (role == 'salon owner') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SalonOwnerBottomNavBar()));
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
    User? user = FirebaseAuth.instance.currentUser;

    if (role == 'salon owner' && user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SalonOwnerBottomNavBar()));
    }
    else if (role == 'client' && user != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
}


// void signInUser(BuildContext context){
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
// }


}
