import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {

  List<Map<String, dynamic>> _bookingList = [];
  List<Map<String, dynamic>> get bookingList => _bookingList;



  void cancelBooking (String docId){
    FirebaseFirestore.instance.collection('appointments').doc(docId).delete();

  }

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


  // void deleteItem(value){
  //   if(value != null){
  //     _bookingList.remove(value);
  //     print(_bookingList);
  //     notifyListeners();
  //   }
  //   else {
  //     print('Value is null');
  //   }
  // }
  void deleteItem(String name) {
    _bookingList.removeWhere((item) => item['serviceName'] == name);
    print(_bookingList);
    notifyListeners();
  }
}