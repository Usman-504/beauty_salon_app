import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../User_ui/auth/login_screen/login_screen.dart';

class AllCategoriesProvider with ChangeNotifier {
  Stream<QuerySnapshot> getServices() {
    return FirebaseFirestore.instance.collection('services').snapshots();
  }

  Stream<QuerySnapshot> getSubServices(catId) {
    return FirebaseFirestore.instance
        .collection('services')
        .doc(catId)
        .collection('subServices')
        .snapshots();
  }



  late List<String> _categoryList = [];
  List<String> get categoryList => _categoryList;


  void getCategories() async {
    await FirebaseFirestore.instance
        .collection('services')
        .snapshots()
        .listen((snapshot) {
      _categoryList = snapshot.docs.map((doc) => doc.id).toList();

      notifyListeners();
      print(categoryList);
    });
  }



  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    });
    notifyListeners();
  }

  void deleteCategory(
    String docId,
  ) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('services')
        .doc(docId)
        .get();

    if (doc.exists) {
      String path = doc.get('image_path');

      if (path.isNotEmpty) {
        await FirebaseStorage.instance.ref(path).delete();
      }

      // Delete all documents in the subcollection
      Future<void> deleteSubCollection(
          String docId, String subcollectionName) async {
        var subcollection = FirebaseFirestore.instance
            .collection('services')
            .doc(docId)
            .collection(subcollectionName);
        var querySnapshot = await subcollection.get();

        // Iterate over all documents in the subcollection and delete them
        for (var document in querySnapshot.docs) {
          if (document.exists && document.data().containsKey('image_path')) {
            String subImagePath = document.get('image_path');
            if (subImagePath.isNotEmpty) {
              await FirebaseStorage.instance.ref(subImagePath).delete();
            }
          }
          await document.reference.delete();
        }
      }

      Future<void> deleteDocumentAndSubCollections(String docId) async {
        // Delete the 'subServices' subcollection
        await deleteSubCollection(docId, 'subServices');

        // After subcollection is deleted, delete the main document
        await FirebaseFirestore.instance
            .collection('services')
            .doc(docId)
            .delete();
      }

      await deleteDocumentAndSubCollections(docId);
    }
  }

  // String capitalizeFirstLetter(String text) {
  //   if (text.isEmpty) return text;  // Return if the string is empty
  //   return text[0].toUpperCase() + text.substring(1).toLowerCase();
  // }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text; // Return if the string is empty

    // Split the string by spaces or underscores
    List<String> words = text.split(RegExp(r'[\s_]+'));

    // Capitalize the first letter of each word
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    // Join the words back into a single string with spaces
    return words.join(' ');
  }
}
