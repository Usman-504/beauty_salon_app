import 'package:flutter/material.dart';

class FavProvider with ChangeNotifier{

  List<int> _favItems = [];
 List<int> get favItems => _favItems;


  void addItem(int value, ){
    _favItems.add(value, );
    notifyListeners();
  }


  void removeItem(int value,){
    _favItems.remove(value);
    notifyListeners();
  }

}

