import 'package:beauty_salon/view_model/user_view_model/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackProvider with ChangeNotifier {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();


  void feedBack (BuildContext context) async{
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Feedback').doc(currentUser!.uid).set({
      'name' : nameController.text.trim(),
      'email' : emailController.text.trim(),
      'message' : messageController.text.trim(),
      'image_url' : profileProvider.profileUrl,
    })
        .then((value){
          Navigator.pop(context);
    });
    notifyListeners();
  }

  Stream<QuerySnapshot> getFeedBacks() {

    return FirebaseFirestore.instance
        .collection('Feedback')
        .snapshots();
  }


}