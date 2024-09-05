import 'package:flutter/material.dart';

class FavProvider with ChangeNotifier{

  List<int> _favServices = [];
 List<int> get favServices => _favServices;


  void addItem(int value, ){
    _favServices.add(value, );
    notifyListeners();
  }


  void removeItem(int value,){
    _favServices.remove(value);
    notifyListeners();
  }

}

