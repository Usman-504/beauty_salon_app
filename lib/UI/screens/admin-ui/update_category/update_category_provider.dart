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

  void updateData(
      String docId, categoryNameController,) async {

    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('services')
        .doc(docId)
        .get();

    String oldImagePath = document.get('image_path');
String categoryName = categoryNameController.text.trim();

    bool isNameChanged = categoryName.isNotEmpty && categoryName != docId;

   if(isNameChanged){
     await FirebaseFirestore.instance
         .collection('services')
         .doc(categoryName)
         .set(Map<String, dynamic>.from(document.data() as Map));

     await FirebaseFirestore.instance
         .collection('services')
         .doc(docId)
         .delete();
   }

    if (_file != null) {

      if(oldImagePath.isNotEmpty){
        await FirebaseStorage.instance.ref(oldImagePath).delete();
      }
      print('Uploading image...');
      await uploadImage();

      if (_imageNewUrl.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('services')
            .doc(categoryName)
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



}