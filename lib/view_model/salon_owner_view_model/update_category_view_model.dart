import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCategoryProvider with ChangeNotifier {
  XFile? _file;
  XFile? get file => _file;
  String _imageNewUrl = '';
  String get imageNewUrl => _imageNewUrl;
  String _imagePath = '';
  String get imagePath => _imagePath;


  void updateData(String catId, String catName) async {

    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('services')
        .doc(catId)
        .get();

    String oldImagePath = document.get('image_path');

    await FirebaseFirestore.instance
        .collection('services')
        .doc(catId.toString())
        .update({
      'category_name': catName,
    });

    if (_file != null) {

      if(oldImagePath.isNotEmpty){
        await FirebaseStorage.instance.ref(oldImagePath).delete();
      }
      print('Uploading image...');
      await uploadImage();

      if (_imageNewUrl.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('services')
            .doc(catId.toString())
            .update({
          'image_url': _imageNewUrl,
          'image_path': _imagePath,
        });
      }
    }
  }

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    _file = await imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (_file != null) {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      // String fileName = _file!.path.split('/').last;
      //${fileName}
      Reference referenceDirImages = referenceRoot.child('images');
      Reference imageToUpload = referenceDirImages.child(uniqueFileName);

      try {
        await imageToUpload.putFile(File(file!.path));
        _imageNewUrl = await imageToUpload.getDownloadURL();
        print('Image updated successfully, URL: $_imageNewUrl');
        print(imageToUpload.fullPath);
        _imagePath = imageToUpload.fullPath;
        notifyListeners();
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }



// void updateData(String docId, categoryNameController,) async {
  //   DocumentSnapshot document = await FirebaseFirestore.instance
  //       .collection('services')
  //       .doc(docId)
  //       .get();
  //
  //   String oldImagePath = document.get('image_path');
  //   String categoryName = categoryNameController.text.trim().toLowerCase();
  //
  //   bool isNameChanged = categoryName.isNotEmpty && categoryName != docId;
  //
  //   if (isNameChanged) {
  //     await FirebaseFirestore.instance
  //         .collection('services')
  //         .doc(categoryName)
  //         .set(Map<String, dynamic>.from(document.data() as Map));
  //
  //     await copySubServices(docId, categoryName);
  //
  //     Future<void> deleteSubCollection(String docId, String subcollectionName) async {
  //       var subcollection = FirebaseFirestore.instance
  //           .collection('services')
  //           .doc(docId)
  //           .collection(subcollectionName);
  //       var querySnapshot = await subcollection.get();
  //
  //       // Iterate over all documents in the subcollection and delete them
  //       for (var document in querySnapshot.docs) {
  //         await document.reference.delete();
  //       }
  //     }
  //
  //     Future<void> deleteDocumentAndSubCollections(String docId) async {
  //       // Delete the 'subServices' subcollection
  //       await deleteSubCollection(docId, 'subServices');
  //
  //       // After subcollection is deleted, delete the main document
  //       await FirebaseFirestore.instance.collection('services').doc(docId).delete();
  //     }
  //
  //     await deleteDocumentAndSubCollections(docId);
  //   }
  //
  //
  //
  //     if (_file != null) {
  //       if (oldImagePath.isNotEmpty) {
  //         await FirebaseStorage.instance.ref(oldImagePath).delete();
  //       }
  //       print('Uploading image...');
  //       await uploadImage();
  //
  //       if (_imageNewUrl.isNotEmpty) {
  //         FirebaseFirestore.instance
  //             .collection('services')
  //             .doc(categoryName)
  //             .update({
  //           'image_url': _imageNewUrl,
  //           'image_path': _imagePath,
  //         });
  //       }
  //     }
  //   }
  //
  // Future<void> copySubServices(String oldDocId, String newDocId) async {
  //   // Reference to the old 'subservices' collection
  //   var oldSubServicesRef = FirebaseFirestore.instance
  //       .collection('services')
  //       .doc(oldDocId)
  //       .collection('subServices');
  //
  //   // Get all documents in the old 'subservices' collection
  //   var oldDocs = await oldSubServicesRef.get();
  //
  //   // Reference to the new 'subservices' collection
  //   var newSubServicesRef = FirebaseFirestore.instance
  //       .collection('services')
  //       .doc(newDocId)
  //       .collection('subServices');
  //
  //   // Copy each document from the old 'subservices' collection to the new one
  //   for (var doc in oldDocs.docs) {
  //     await newSubServicesRef.doc(doc.id).set(doc.data());
  //   }
  // }
  //
  //   void pickImage() async {
  //     ImagePicker imagePicker = ImagePicker();
  //     _file = await imagePicker.pickImage(source: ImageSource.gallery);
  //     notifyListeners();
  //   }
  //
  //   Future<void> uploadImage() async {
  //     if (_file != null) {
  //       String uniqueFileName = DateTime
  //           .now()
  //           .millisecondsSinceEpoch
  //           .toString();
  //       Reference referenceRoot = FirebaseStorage.instance.ref();
  //       // String fileName = _file!.path.split('/').last;
  //       //${fileName}
  //       Reference referenceDirImages = referenceRoot.child('images');
  //       Reference imageToUpload = referenceDirImages.child(uniqueFileName);
  //
  //       try {
  //         await imageToUpload.putFile(File(file!.path));
  //         _imageNewUrl = await imageToUpload.getDownloadURL();
  //         print('Image updated successfully, URL: $_imageNewUrl');
  //         print(imageToUpload.fullPath);
  //         _imagePath = imageToUpload.fullPath;
  //         notifyListeners();
  //       } catch (e) {
  //         print('Failed to upload image: $e');
  //       }
  //     }
  //   }



}