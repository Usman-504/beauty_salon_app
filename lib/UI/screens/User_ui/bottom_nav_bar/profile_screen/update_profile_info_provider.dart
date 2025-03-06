import 'dart:io';

import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/salon_owner_ui/bottom_nav_bar/salon_owner_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/login_screen/login_screen.dart';

class UpdateProfileInfoProvider with ChangeNotifier {



  String _imageUrl = '';
  String get imageUrl => _imageUrl;



  String _imagePath = '';
  String get imagePath => _imagePath;

  XFile? _file;
  XFile? get file => _file;

  void updateUserDetails(String name, String email, String phoneNo, String docId,
      String password, BuildContext context) async {

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (password.isEmpty) {
        Utils().showSnackBar(context, 'Password Cannot Be Empty');
        return;
      }

      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(docId)
          .get();
      String userName = userDoc.get('name');
      String userPhone = userDoc.get('phone_no');

      if (email != user.email) {
        await user.verifyBeforeUpdateEmail(email);
        await user.sendEmailVerification();

        await FirebaseAuth.instance.signOut();
        Utils().showSnackBar(context, 'Verify Your New Email & Login Again');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
        return;
      }

      if (name != userName || phoneNo != userPhone) {
        await FirebaseFirestore.instance.collection('user').doc(docId).update({
          'name': name,
          'phone_no': phoneNo,
          'email': email,
        });
       SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('name', name);

        if (name != userName) {
          Utils().showSnackBar(context, 'Profile Name Updated.');
        } else if (phoneNo != userPhone) {
          Utils().showSnackBar(context, 'Phone Number Updated.');
        }

          String? role = sp.getString('role');
          if(role == 'client'){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
            return;
          }
          else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SalonOwnerBottomNavBar()));
            return;
          }


      }

      await updateProfilePhoto(docId);
      if(_file != null){
        Utils().showSnackBar(context, 'Profile Photo Updated');
      }
      else {
        Utils().showSnackBar(context, 'Profile Updated');
      }
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? role = sp.getString('role');
      if(role == 'client'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
        return;
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SalonOwnerBottomNavBar()));
        return;
      }


    } on FirebaseException catch (e) {
      if (e.code == 'invalid-credential') {
        Utils().showSnackBar(context, 'Your Password Is Incorrect');
      } else if (e.code == 'too-many-requests') {
        Utils().showSnackBar(context, 'Too Many Requests. Try Again Later');
      }
    } catch (e) {
      print(e);
    }
  }

 Future<void> updateProfilePhoto(String docId) async {


    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('user')
        .doc(docId)
        .get();

    String oldImagePath = document.get('image_path');


    if (_file != null) {

      if(oldImagePath.isNotEmpty){
        await FirebaseStorage.instance.ref(oldImagePath).delete();
      }
      print('Uploading image...');
      await uploadImage();

      if (_imageUrl.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(docId)
            .update({
          'image_url': _imageUrl,
          'image_path': _imagePath,
        });
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('profile_url', _imageUrl);
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
      Reference referenceDirImages = referenceRoot.child('ProfileImages');
      Reference imageToUpload = referenceDirImages.child(uniqueFileName);

      try {
        await imageToUpload.putFile(File(file!.path));
        _imageUrl = await imageToUpload.getDownloadURL();
        print('Image updated successfully, URL: $_imageUrl');
        print(imageToUpload.fullPath);
        _imagePath = imageToUpload.fullPath;
        notifyListeners();
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }

  void clearFields() {
    _file = null;
    _imageUrl = '';
    notifyListeners();
  }

}
