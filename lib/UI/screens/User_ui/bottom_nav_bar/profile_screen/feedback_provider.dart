import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackProvider with ChangeNotifier {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();


  void feedBack (BuildContext context) async{
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Feedback').doc(currentUser!.uid).set({
      'name' : nameController.text.trim(),
      'email' : emailController.text.trim(),
      'message' : messageController.text.trim(),
    })
        .then((value){
          Navigator.pop(context);
    });
    notifyListeners();
  }


}