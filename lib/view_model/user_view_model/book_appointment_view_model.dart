import 'dart:convert';

import 'package:beauty_salon/utils/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../res/components/snackbar.dart';


class BookAppointmentProvider with ChangeNotifier {
  DateTime? _selectedDate  ;
  DateTime? get selectedDate => _selectedDate;
  String? _selectedTimeSlot;
  String? get selectedTimeSlot => _selectedTimeSlot;
  List<String> _selectedTimeSlots = [];
  List<String> get selectedTimeSlots => _selectedTimeSlots;
  String? _serviceType;
  String? get serviceType => _serviceType;
  String? _formattedDate;
  String? get formattedDate => _formattedDate;
  int gstPrice = 49;
  int _totalPrice = 0;
  int get totalPrice => _totalPrice;
  String _role = '';
  String get role => _role;

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

  bool isPaymentSuccessful = false;

  bool _paymentLoading = false;
  bool get paymentLoading => _paymentLoading;

  void setPaymentLoading(bool value) {
    _paymentLoading = value;
    notifyListeners();
  }

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

  void getRole() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _role = sp.getString('role')!;
    notifyListeners();
  }

  void acceptAppointment(String docId, BuildContext context) async {

    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(docId)
        .update({
      'appointment_status': 'Accepted',
    });
    notifyListeners();
    Utils().showSnackBar(context, 'Appointment Accepted');
    Navigator.pop(context);
  }

  void rejectAppointment(String docId, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(docId)
        .update({
      'appointment_status': 'Rejected',
    });
    notifyListeners();
    Utils().showSnackBar(context, 'Appointment Rejected');
    Navigator.pop(context);
  }

  void clearFields() {
    _selectedTimeSlot = null;
    _selectedTimeSlots.clear();
    _serviceType = null;
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    messageController.clear();
  }

  void onDateChange(date) {
    _selectedDate = date;
    clearFields();
    notifyListeners();
  }

  void onTimeChange(String time) {
    _selectedTimeSlot = time;
    notifyListeners();
  }

  void selectTimeSlot(String time, int maxSlots) {


    if (_selectedTimeSlots.contains(time)) {
      _selectedTimeSlots.remove(time);
    } else {
      if (_selectedTimeSlots.length < maxSlots) {
        _selectedTimeSlots.add(time);
      } else {
        return;
      }
    }
    print(_selectedTimeSlots);
    notifyListeners();
  }


  void Salon() {
    _serviceType = 'Salon';
    notifyListeners();
  }

  void Home() {
    _serviceType = 'Home';
    notifyListeners();
  }

  bool validation(BuildContext context, bool cart, int cartLength, ) {
    if (_selectedDate == null) {
      Utils().showSnackBar(context, 'Please Select Date');
      return false;
    }
    else if (_selectedTimeSlot == null && !cart) {
      Utils().showSnackBar(context, 'Please Select Time');
      return false;
    }
    else if (_selectedTimeSlots.isEmpty && cart) {
      Utils().showSnackBar(context, 'Please Select Time Slots');
      return false;
    }
    else if (cart && _selectedTimeSlots.length < cartLength) {
      Utils().showSnackBar(context, 'Please Select $cartLength Time Slots');
      return false;
    }
    else if (nameController.text.isEmpty) {
      Utils().showSnackBar(context, 'Please Enter Name');
      return false;
    } else if (phoneController.text.isEmpty) {
      Utils().showSnackBar(context, 'Please Enter Phone Number');
      return false;
    } else if (addressController.text.isEmpty) {
      Utils().showSnackBar(context, 'Please Enter Address');
      return false;
    } else if (_serviceType == null) {
      Utils().showSnackBar(context, 'Please Select Service Type');
      return false;
    }
    return true;
  }

  Future<void> appointment(
      String appointmentDate,
      String serviceType,
      int totalPrice,
      String name,
      String phone,
      String address,
      String message,
      BuildContext context,
  {
    String? imageUrl,
    List? imageUrls,
    String? serviceName,
    List? serviceNames,
    int? servicePrice,
    List? servicePrices,
    String? appointmentTime,
    List? appointmentTimes,
  }) async {
    print(isPaymentSuccessful);
    if (!isPaymentSuccessful) {
      Utils().showSnackBar( context, 'Please complete the payment first',);
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    final appointment = await FirebaseFirestore.instance
        .collection('appointments')
        .where('appointment_time', isEqualTo: appointmentTime)
        .where('appointment_date', isEqualTo: appointmentDate)
        .get();
    final multiAppointment = await FirebaseFirestore.instance
        .collection('appointments')
        .where('appointment_times', isEqualTo: appointmentTimes)
        .where('appointment_date', isEqualTo: appointmentDate)
        .get();
    if (appointment.docs.isEmpty || multiAppointment.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('appointments').doc().set({
        'customer_name': name,
        'customer_number': phone,
        'customer_address': address,
        'customer_message': message,
        'service_name': serviceName,
        'service_names': serviceNames,
        'service_price': servicePrice,
        'service_prices': servicePrices,
        'appointment_date': appointmentDate,
        'appointment_time': appointmentTime,
        'appointment_times': appointmentTimes,
        'service_type': serviceType,
        'total_price': totalPrice,
        'image_url': imageUrl,
        'image_urls': imageUrls,
        'appointment_status': 'Pending',
        'user_id': user!.uid,
      });
      isPaymentSuccessful = false;
      notifyListeners();
      Utils().orderCompleted(context);
    }
    else{
      Utils().showSnackBar(context, 'Appointment Already Present');
    }
  }

  void calculateTotalPrice(int servicePrice) {
    _totalPrice = servicePrice + gstPrice;
    notifyListeners();
  }

  void calculatePrice(List<int> servicePrice) {
    _totalPrice = servicePrice.fold(0, (add, price) => add + price) + gstPrice;
    notifyListeners();
  }



// Stream<QuerySnapshot> getAppointments()  {
//     User? user = FirebaseAuth.instance.currentUser;
//   return FirebaseFirestore.instance.collection('appointments').where('user_id', isEqualTo: user!.uid).snapshots();
// }
  Stream<QuerySnapshot> getPendingAppointments() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('user_id', isEqualTo: user!.uid)
        .where('appointment_status', isEqualTo: 'Pending')
        .snapshots();
  }
  Stream<QuerySnapshot> getAllPendingAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('appointment_status', isEqualTo: 'Pending')
        .snapshots();
  }

  Stream<QuerySnapshot> getUpComingAppointments() {
    User? user = FirebaseAuth.instance.currentUser;

    return FirebaseFirestore.instance
        .collection('appointments')
        .where('user_id', isEqualTo: user!.uid)
        .where('appointment_status', isEqualTo: 'Accepted')
        .where('appointment_date', isGreaterThanOrEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now()))
      //  .where('appointment_time', isGreaterThan:  DateFormat('HH:mm a').format(DateTime.now()))
        .snapshots();
  }
  Stream<QuerySnapshot> getAllUpComingAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('appointment_status', isEqualTo: 'Accepted')
        .where('appointment_date', isGreaterThanOrEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now()))
       // .where('appointment_time', isGreaterThan:  DateFormat('HH:mm ').format(DateTime.now()))
        .snapshots();
  }

  Stream<QuerySnapshot> getPastAppointments() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('user_id', isEqualTo: user!.uid)
        .where('appointment_status', isEqualTo: 'Accepted')
        .where('appointment_date',
            isLessThan: DateFormat('dd/MM/yyyy').format(DateTime.now()))
      //  .where('appointment_time', isLessThan:  DateFormat('HH:mm').format(DateTime.now()))
        .snapshots();
  }
  Stream<QuerySnapshot> getAllPastAppointments() {

    return FirebaseFirestore.instance
        .collection('appointments')
        .where('appointment_status', isEqualTo: 'Accepted')
        .where('appointment_date',
            isLessThan: DateFormat('dd/MM/yyyy').format(DateTime.now()))
      //  .where('appointment_time', isLessThan:  DateFormat('HH:mm').format(DateTime.now()))
        .snapshots();
  }

  Stream<QuerySnapshot> getRejectedAppointments() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('user_id', isEqualTo: user!.uid)
        .where('appointment_status', isEqualTo: 'Rejected')
        .snapshots();
  }
  Stream<QuerySnapshot> getAllRejectedAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('appointment_status', isEqualTo: 'Rejected')
        .snapshots();
  }

  void getStream(Stream<dynamic> stream, builder) {}

  Stream<QuerySnapshot> getAllAppointments() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection('appointments').snapshots();
  }

  Map<String, dynamic>? intentPaymentData;

  showPaymentSheet(BuildContext context) async{
    try{
      await Stripe.instance.presentPaymentSheet().then((val){
        isPaymentSuccessful = true;
        intentPaymentData = null;
        notifyListeners();
      }).onError((errorMsg, sTrace){
        print(errorMsg);
        print(sTrace);
      });
    }
    on StripeException catch (error){
      print(error);

      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          content: Text('Cancelled'),
        );
      },);
    }
    catch(e)
    {
      print(e);
    }
  }

  makeIntentForPayment(amount, currency, BuildContext context) async{
    try{
      Map<String, dynamic>? paymentInfo = {
        'amount' : (amount * 100 ).toString(),
        'currency': currency,
        'payment_method_types[]' : 'card',
      };

      var responseFromStripeApi = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: paymentInfo,
          headers: {
            'Authorization' : 'Bearer ${Assets.stripeSecretKey}',
            'Content-Type' : 'application/x-www-form-urlencoded',
          }
      );
      print('Response: ${responseFromStripeApi.body.toString()}');
      return jsonDecode(responseFromStripeApi.body);

    }
    catch(e){
      print(e);
    }
  }

  paymentSheet(amount, currency, BuildContext context) async{
    try{
      if (isPaymentSuccessful) {
        Utils().showSnackBar( context, 'Payment Already Completed',);
        return;
      }
      setPaymentLoading(true);
      intentPaymentData =  await makeIntentForPayment(amount, currency, context);
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intentPaymentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Beautilly'
      )).then((value){
        setPaymentLoading(false);
        print(value);
      });

      showPaymentSheet(context);
    }
    catch(e){
      setPaymentLoading(false);
      print(e);
    }
  }

  @override
  void dispose() {
   _selectedTimeSlots.clear();
   _selectedTimeSlots = [];
   _selectedTimeSlot = null;
   _selectedDate = null;
    super.dispose();
  }
}
