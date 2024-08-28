import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  String? validation  (){
    if (nameController.text.isEmpty) {
      return 'Please Enter Your Name';
    }
    else if (emailController.text.isEmpty) {
      return 'Please Enter Your Email';
    }
    else if (phoneNoController.text.isEmpty) {
      return 'Please Enter Your Phone No';
    }
    else if (passwordController.text.isEmpty) {
      return 'Please Enter Your Password';
    }
    return null;
  }

  Future<String?> signUp() async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()).then((value){
        FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'name' : nameController.text.trim(),
          'phone_no' : phoneNoController.text.trim(),
          'email' : FirebaseAuth.instance.currentUser!.email,
          'role' : 'client',
          'user_id' : FirebaseAuth.instance.currentUser!.uid,
        });
      });
      notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The Email Format is Invalid.';
      }
      else if (e.code == 'email-already-in-use') {
        return 'This Email Is Already Registered.';
      }
      else if (e.code == 'weak-password') {
        return 'Password Must Be At Least 6 Characters';
      }
      else {
        return'An error occurred';

      }
    }
  }

}