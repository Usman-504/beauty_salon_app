import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/UI/screens/User_ui/auth/signup_screen/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../generated/assets.dart';
import '../../auth/login_screen/login_screen.dart';

class ProfileProvider with ChangeNotifier{

late String _name = '';
  String get name=> _name;

String _userName = '';
String get userName=> _userName;

String _userEmail = '';
String get userEmail=> _userEmail;

String _userPhone = '';
String get userPhone=> _userPhone;

 late String _email = '';
  String? get email=> _email;

late String _profileUrl = '';
String get profileUrl => _profileUrl;

  void fetchUserDetails ()async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name') ?? '';
    _email = sp.getString('email') ?? '';
    _profileUrl = sp.getString('profile_url') ?? '';
    notifyListeners();
  }

  void userDetails() async{
    User? user = FirebaseAuth.instance.currentUser;

   DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
   _userName = userDoc.get('name');
   _userEmail = userDoc.get('email');
   _userPhone = userDoc.get('phone_no');
    notifyListeners();
   print(userEmail);
   print(userName);
   print(userPhone);
  }

Future<void> deleteUser (BuildContext context) async{
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    String imagePath = userDoc.get('image_path');
    if(imagePath.isNotEmpty){
      await FirebaseStorage.instance.ref(imagePath).delete();
    }
    await FirebaseFirestore.instance.collection('user').doc(user.uid).delete();
    await user.delete();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const SignUpScreen()), (Route<dynamic> route) => false,);
    Utils().showSnackBar(context, 'Account Deleted Successfully');
}
// void getProfileImage() async{
//   User? user = FirebaseAuth.instance.currentUser;
//   DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
//   String imageUrl = userDoc.get('image_url') ;
//   if(imageUrl.isNotEmpty) {
//     // SharedPreferences sp = await SharedPreferences.getInstance();
//     // sp.setString('profile_url', imageUrl);
//     notifyListeners();
//
//   }
//
//
// }



}