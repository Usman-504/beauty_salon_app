import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryProvider with ChangeNotifier {
  TextEditingController categoryNameController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  String _imageUrl = '';
  String get imageUrl => _imageUrl;

  String _imagePath = '';
  String get imagePath => _imagePath;

  XFile? _file;
  XFile? get file => _file;

  void clearFields() {
    categoryNameController.clear();
    _file = null;
    _imageUrl = '';
    notifyListeners();
  }

  String? validation() {
    if (_file == null) {
      return 'Please Upload Image/Icon';
    } else if (categoryNameController.text.isEmpty) {
      return 'Please Enter Category Name';
    }
    return null;
  }

  void addData() async {
    if (_file != null && _imageUrl.isEmpty) {
      print('Uploading image...');
      await uploadImage();
    }

    if (_imageUrl.isNotEmpty) {
      await FirebaseFirestore.instance.collection('services').doc(categoryNameController.text.trim().toLowerCase()).set({
      //  'Account Name': categoryNameController.text.trim(),
        'image_url': _imageUrl,
        'image_path': _imagePath,
      });
      print('Data saved successfully!');
    } else {
      print('Image URL is empty, not saving data.');
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
      Reference referenceDirImages = referenceRoot.child('images');
      Reference imageToUpload = referenceDirImages.child(uniqueFileName);
      try {
        await imageToUpload.putFile(File(file!.path));
        _imageUrl = await imageToUpload.getDownloadURL();
        _imagePath = imageToUpload.fullPath;
        print(imageToUpload.fullPath);

        print('Image uploaded successfully, URL: $_imageUrl');
        notifyListeners();
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }

  void deleteImage(String docId) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Passwords')
        .doc(docId)
        .get();
    if (doc.exists) {
      String path = doc['images/${uniqueFileName}'];

      if(path.isNotEmpty){
        await FirebaseStorage.instance.ref().delete();
      }
    }
  }
}