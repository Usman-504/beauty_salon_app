import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../view/user_view/login_view.dart';

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

  late List<String> _categoryNameList = [];
  List<String> get categoryNameList => _categoryNameList;

List<DocumentSnapshot> _searchResult = [];
List<DocumentSnapshot> get searchResult =>_searchResult;

  List<DocumentSnapshot> serviceCategoryList = [];

  Stream<QuerySnapshot> getSpecificService() {
    return FirebaseFirestore.instance.collection('services').snapshots();
  }

  void searchService(String query) {
    if (query.isEmpty) {
      _searchResult = serviceCategoryList;
    } else {
      _searchResult =serviceCategoryList.where((category) {
        final categoryName = category['category_name'].toLowerCase();
        return categoryName.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }


  void getServiceCategories() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
      serviceCategoryList = snapshot.docs;
      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching categories: $error');
    }
  }

  void getCategories() async {
    await FirebaseFirestore.instance
        .collection('services')
        .snapshots()
        .listen((snapshot) {
      _categoryList = snapshot.docs.map((doc) => doc.id).toList();

      // notifyListeners();
      // getCategoryTitle();
      notifyListeners();
      print(categoryList);
    });
  }


  void getCategoryName() async {
    await FirebaseFirestore.instance
        .collection('services')
        .snapshots()
        .listen((snapshot) {
      _categoryNameList = snapshot.docs.map((doc) => doc['category_name'].toString()).toList();
      notifyListeners();
      print(categoryNameList);
    });
  }


// void getCategoryTitle () async{
//   for(String i in categoryList) {
//     var docSnap = await FirebaseFirestore.instance.collection('services').doc(i).get();
//     var catName = docSnap.get('category_name');
//     _categoryNameList.add(catName);
//   }
//
// }



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


      Future<void> deleteSubCollection(
          String docId, String subCollectionName) async {
        var subCollection = FirebaseFirestore.instance
            .collection('services')
            .doc(docId)
            .collection(subCollectionName);
        var querySnapshot = await subCollection.get();

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
        await deleteSubCollection(docId, 'subServices');

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
    if (text.isEmpty) return text;

    List<String> words = text.split(RegExp(r'[\s_]+'));


    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }


    return words.join(' ');
  }
}
