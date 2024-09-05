import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class AdminServicesProvider with ChangeNotifier{


  void deletePassword (String docId) async {

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Passwords')
        .doc(docId)
        .get();
    if (doc.exists) {
      String path = doc.get('image_path');

      if(path.isNotEmpty){
        await FirebaseStorage.instance.ref(path).delete();
      }
      await FirebaseFirestore.instance
          .collection('Passwords')
          .doc(docId)
          .delete();
    }

  }

}