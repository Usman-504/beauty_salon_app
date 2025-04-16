import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/components/snackbar.dart';

class ForgetPasswordProvider  with ChangeNotifier{

  TextEditingController emailController = TextEditingController();



  void resetPassword( BuildContext context) async{
    if(emailController.text.isEmpty){
      Utils().showSnackBar(context, 'Please Enter Email');
      return;
    }
    if (!isValidEmail(emailController.text.trim())) {
      Utils().showSnackBar(context, 'The Email Format Is Invalid.');
      return;
    }
      try{

        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: emailController.text.trim())
            .get();

        if (result.docs.isEmpty) {

          Utils().showSnackBar(context, 'No User found For That Email.');
          return;
        }


        await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim()).then((value){
          Utils().showSnackBar(context, 'Email Reset Link Sent Successfully');
          Navigator.pop(context);
        });


      }
      on FirebaseAuthException catch (e){
        if(e.code == 'invalid-email'){
          Utils().showSnackBar(context, 'The Email Format Is Invalid.');
        }
        else if (e.code == 'network-request-failed') {
          Utils().showSnackBar(context,'Check Your Internet Connection.') ;
        }
        return;
      }
      notifyListeners();



  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  void clearFields(){
    emailController.clear();
    notifyListeners();
  }

}