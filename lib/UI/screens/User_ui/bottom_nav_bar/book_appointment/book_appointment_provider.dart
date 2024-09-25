import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../components/snackbar.dart';

class BookAppointmentProvider with ChangeNotifier {

 DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  String? _selectedTimeSlot;
  String? get selectedTimeSlot => _selectedTimeSlot;
  String? _serviceType;
  String? get serviceType => _serviceType;
  String? _formattedDate;
  String? get formattedDate => _formattedDate;
 int gstPrice = 49;
 int _totalPrice = 0;
 int get totalPrice => _totalPrice;
 //int get totalPrice => widget.servicePrice + gstPrice;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController messageController = TextEditingController();

 // List<String> availableTime = [
 //   '09:00 AM', '09:45 AM', '10:30 AM',
 //   '11:15 AM', '12:00 PM', '12:45 PM', '01:30 PM',
 //   '02:15 PM', '03:00 PM', '04:45 PM', '05:30 PM',
 //   '06:15 PM',
 // ];

 List<TimeOfDay> availableTime = [
   TimeOfDay(hour: 9, minute: 45),
   TimeOfDay(hour: 10, minute: 30),
   TimeOfDay(hour: 11, minute: 15),
   TimeOfDay(hour: 12, minute: 0),
   TimeOfDay(hour: 12, minute: 45),
   TimeOfDay(hour: 13, minute: 30),
   TimeOfDay(hour: 14, minute: 15),
   TimeOfDay(hour: 15, minute: 0),
   TimeOfDay(hour: 15, minute: 45),
   TimeOfDay(hour: 16, minute: 30),
   TimeOfDay(hour: 17, minute: 15),
   TimeOfDay(hour: 18, minute: 0),

 ];



  void clearFields(){
    _selectedTimeSlot = null;
    _serviceType = null;
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    messageController.clear();
  }


  void onDateChange(date){
    _selectedDate = date;
    notifyListeners();
  }

  void onTimeChange(String time){
    _selectedTimeSlot = time;
    notifyListeners();
  }



  void Salon(){
    _serviceType = 'Salon';
    notifyListeners();
  }

  void Home(){
    _serviceType = 'Home';
    notifyListeners();
  }

  bool validation(BuildContext context){
    if(_selectedTimeSlot ==null ){
      Utils().showSnackBar(context, 'Please Select Time');
      return false;
    }
    else if (nameController.text.isEmpty) {
      Utils().showSnackBar(context, 'Please Enter Name');
      return false;
    }
    else if (phoneController.text.isEmpty) {
      Utils().showSnackBar(context, 'Please Enter Phone Number');
      return false;
    }
    else if (addressController.text.isEmpty) {
      Utils().showSnackBar(context, 'Please Enter Address');
      return false;
    }
    else if (_serviceType ==null) {
      Utils().showSnackBar(context, 'Please Select Service Type');
      return false;
    }
    return true;

    }

    Future<void> appointment (
        String serviceName, int servicePrice, String appointmentDate,
        String appointmentTime, String serviceType, int totalPrice, String imageUrl) async {
      User? user = FirebaseAuth.instance.currentUser;
      final appointment = await FirebaseFirestore.instance.collection(
          'appointments')
          .where('appointment_time', isEqualTo: appointmentTime)
          .where('appointment_date', isEqualTo: appointmentDate)
          .get();
      if (appointment.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('appointments').doc().set({
          'customer_name': nameController.text.trim(),
          'customer_number': phoneController.text.trim(),
          'customer_address': addressController.text.trim(),
          'customer_message': messageController.text.trim(),
          'service_name': serviceName,
          'service_price': servicePrice,
          'appointment_date': appointmentDate,
          'appointment_time': appointmentTime,
          'service_type': serviceType,
          'total_price': totalPrice,
          'image_url': imageUrl,
          'user_id': user!.uid,
        });
      }
    }

void calculateTotalPrice(int servicePrice){
    _totalPrice = servicePrice + gstPrice;
    notifyListeners();
}




Stream<QuerySnapshot> getAppointments()  {
    User? user = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance.collection('appointments').where('user_id', isEqualTo: user!.uid).snapshots();
}

Stream<QuerySnapshot> getAllAppointments()  {
    User? user = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance.collection('appointments').snapshots();
}
}