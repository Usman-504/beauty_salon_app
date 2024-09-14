import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void fetchUserDetails ()async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name') ?? '';
    _email = sp.getString('email') ?? '';
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






}