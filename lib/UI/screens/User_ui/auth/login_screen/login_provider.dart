import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void clearFields() {
   emailController.clear();
   passwordController.clear();
   notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _obscureText = true;
 bool get  obscureText => _obscureText;

  void changeVisibility(){
    _obscureText = !_obscureText;
    notifyListeners();
  }

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
      setLoading(true);
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
     String photo = userDoc.get('image_url');
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('role', role);
      sp.setString('name', name);
      sp.setString('email', email);
      sp.setString('profile_url', photo);
      print(sp.getString('role'));
      setLoading(false);
      return null;
    } on FirebaseException catch (e) {
      setLoading(false);
      if (e.code == 'invalid-email') {
        return 'The Email Format Is Invalid.';
      } else if (e.code == 'invalid-credential') {
        return 'Email Or Password Is Incorrect.';
      }else if (e.code == 'network-request-failed') {
        return 'Check Your Internet Connection.';
      } else {
        return 'An error occurred';
      }
    }
  }


}
