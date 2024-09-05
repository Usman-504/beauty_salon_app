import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../User_ui/auth/login_screen/login_screen.dart';


class AllCategoriesProvider with ChangeNotifier{

  Stream<QuerySnapshot> getServices() {
  return FirebaseFirestore.instance
      .collection('services')
  // .where('user_id', isEqualTo: currentUser!.uid) // Uncomment if needed
      .snapshots();
}


  List<String> _categoryList = [];
  List<String> get categoryList => _categoryList;


  void getCategories() {
    FirebaseFirestore.instance.collection('services').snapshots().listen((snapshot) {
      _categoryList = snapshot.docs.map((doc) => doc.id).toList();
      print(categoryList);
    });
  }


void logout(BuildContext context){

    FirebaseAuth.instance.signOut().then((_){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const LoginScreen()), (Route<dynamic> route) => false,);
    });
    notifyListeners();
  }

  void deleteCategory (String docId) async {

    //String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('services')
        .doc(docId)
        .get();
    if (doc.exists) {
      String path = doc.get('image_path');

      if(path.isNotEmpty){
        await FirebaseStorage.instance.ref(path).delete();
      }
      await FirebaseFirestore.instance
          .collection('services')
          .doc(docId)
          .delete();
    }

  }

}