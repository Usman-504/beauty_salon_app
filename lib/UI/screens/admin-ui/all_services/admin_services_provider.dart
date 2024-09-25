import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class AdminServicesProvider with ChangeNotifier{


  
  
  Future<Map<String, dynamic>?> fetchDocumentAsMap(String catId, String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('services')
          .doc(catId).collection('subServices').doc(docId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        print("Document does not exist!");
        return null;
      }
    } catch (e) {
      print("Error fetching document: $e");
      return null;
    }
  }




  void deleteService (String catId, String docId) async {

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('services')
        .doc(catId).collection('subServices').doc(docId)
        .get();
    if (doc.exists) {
      String path = doc.get('image_path');

      if(path.isNotEmpty){
        await FirebaseStorage.instance.ref(path).delete();
      }
      await FirebaseFirestore.instance
          .collection('services').doc(catId).collection('subServices')
          .doc(docId)
          .delete();
    }

  }

  // getData (){
  //   Stream<QuerySnapshot<Map<String, dynamic>>> stream =
  //   FirebaseFirestore.instance.collection('services').snapshots();
  //
  //   stream.listen(
  //         (QuerySnapshot<Map<String, dynamic>> snapshot) async {
  //       int i = 0;
  //       for (var element in snapshot.docs) {
  //         debugPrint('Data of $i element${element.data().toString()}');
  //         var stream =
  //             FirebaseFirestore.instance.collection('services').doc().get();
  //         print(stream);
  //         var docData =
  //             await FirebaseFirestore.instance.collection('services').doc().get();
  //
  //         debugPrint('Data of random doc: ${docData.data().toString()}');
  //
  //         i++;
  //       }
  //     },
  //   );
  // }

}