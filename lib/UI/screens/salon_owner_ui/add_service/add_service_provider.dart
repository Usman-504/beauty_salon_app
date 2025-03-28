import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AddServiceProvider with ChangeNotifier {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  String _imageUrl = '';
  String get imageUrl => _imageUrl;

  String _imagePath = '';
  String get imagePath => _imagePath;

  XFile? _file;
  XFile? get file => _file;

  // List<String> _categoryName = [];
  // List<String> get categoryName => _categoryName;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  String? _selectedDoc;
  String? get selectedDoc => _selectedDoc;

 // set selectedCategory(String? selectedItem) {
   // _selectedCategory = selectedItem;
  //  notifyListeners();
  //}

void selectedDocument () async{
    var catDoc = await FirebaseFirestore.instance.collection('services').where('category_name', isEqualTo: _selectedCategory).get();
var doc = catDoc.docs.first;
_selectedDoc = doc.id;
notifyListeners();
}

  void clearFields() {
    serviceNameController.clear();
    servicePriceController.clear();
    serviceDescriptionController.clear();
    _file = null;
    _imageUrl = '';
    notifyListeners();
  }

  String? validation() {

    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      return 'Please Select Category First';
    }
    if (_file == null) {
      return 'Please Upload Image/Icon';
    }
    else if (serviceNameController.text.isEmpty) {
      return 'Please Enter Category Name';
    }
    return null;
  }

  void addData(String docId) async {
    if (_file != null && _imageUrl.isEmpty) {
      print('Uploading image...');
      await uploadImage();
    }

    if (_imageUrl.isNotEmpty) {
      var stringPrice = servicePriceController.text.trim();
      var price = int.tryParse(stringPrice);
      await FirebaseFirestore.instance.collection('services').doc(docId).collection('subServices').doc(serviceNameController.text.trim().toLowerCase()).
      set({
        'service_name' : serviceNameController.text.trim(),
        'service_price' : price,
        'service_description' : serviceDescriptionController.text.trim(),
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

  // void deleteImage(String docId) async {
  //   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   DocumentSnapshot doc = await FirebaseFirestore.instance
  //       .collection('Passwords')
  //       .doc(docId)
  //       .get();
  //   if (doc.exists) {
  //     String path = doc['images/${uniqueFileName}'];
  //
  //     if(path.isNotEmpty){
  //       await FirebaseStorage.instance.ref().delete();
  //     }
  //   }
  // }
  //
  void dropDownCategory (String? selectedItem){
    _selectedCategory = selectedItem;

    notifyListeners();
  }

 // QuerySnapshot docId = FirebaseFirestore.instance.collection('services').doc() as QuerySnapshot<Object?>;

  // void categoryItems (){
  //
  //     _categoryName.add(docId.toString());
  //     notifyListeners();
  //   }

  }
