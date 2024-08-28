import 'package:flutter/material.dart';

class FavStylistsProvider with ChangeNotifier{

  List<int> _favStylists = [];
  List<int> get favStylists => _favStylists;


  void addItem(int value, ){
    _favStylists.add(value, );
    notifyListeners();
  }


  void removeItem(int value,){
    _favStylists.remove(value);
    notifyListeners();
  }

}