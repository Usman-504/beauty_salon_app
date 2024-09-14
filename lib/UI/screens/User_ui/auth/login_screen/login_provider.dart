import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/UI/screens/User_ui/auth/auth_check.dart';
import 'package:beauty_salon/UI/screens/User_ui/auth/signup_screen/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validation() {
    if (emailController.text.isEmpty) {
      return 'Please Enter Your Email';
    } else if (passwordController.text.isEmpty) {
      return 'Please Enter Your Password';
    }
    return null;
  }

  Future<String?> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      String role = userDoc.get('role');
      String name = userDoc.get('name');
      String email = userDoc.get('email');
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('role', role);
      sp.setString('name', name);
      sp.setString('email', email);
      print(sp.getString('role'));

      notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The Email Format Is Invalid.';
      } else if (e.code == 'invalid-credential') {
        return 'Email Or Password Is Incorrect.';
      } else {
        return 'An error occurred';
      }
    }
  }


}
