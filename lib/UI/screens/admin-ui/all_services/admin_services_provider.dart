import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class AdminServicesProvider with ChangeNotifier{





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