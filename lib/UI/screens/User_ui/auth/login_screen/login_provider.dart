import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validation  (){
    if (emailController.text.isEmpty) {
      return 'Please Enter Your Email';
    }
    else if (passwordController.text.isEmpty) {
      return 'Please Enter Your Password';
    }
    return null;
  }

  Future<String?> login() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
      notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The Email Format Is Invalid.';
      }
      else if (e.code == 'invalid-credential') {
        return 'Email Or Password Is Incorrect.';
      }

      else {
        return'An error occurred';

      }
    }
  }
}