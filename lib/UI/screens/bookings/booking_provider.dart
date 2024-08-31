import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {

  List<Map<String, dynamic>> _bookingList = [];
  List<Map<String, dynamic>> get bookingList => _bookingList;


  void addItem(value){
    if(value != null){
      _bookingList.add(value);
      print(_bookingList);
      notifyListeners();
    }
    else {
      print('Value is null');
    }
  }
}