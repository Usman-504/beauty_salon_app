import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {


  int _quantity = 01;
  List<Map<String, dynamic>> _itemsList = [];

  List<Map<String, dynamic>>  get itemsList => _itemsList;
  int get quantity=> _quantity;


  void addItem(value){
    if(value != null){
      _itemsList.add(value);
      print(_itemsList);
      notifyListeners();
    }
    else {
      print('Value is null');
    }
  }


  void removeItem(value){
    if(value != null){
      _itemsList.remove(value);
      print(_itemsList);
      notifyListeners();
    }
    else {
      print('Value is null');
    }
  }

  void incrementQuantity(){
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity(){
    if(_quantity>1){
      _quantity--;
      notifyListeners();
    }

  }

}