import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier{

late String _name = '';
  String get name=> _name;

 late String _email = '';
  String? get email=> _email;

  void fetchUserDetails ()async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name') ?? '';
    _email = sp.getString('email') ?? '';
    notifyListeners();
  }

}