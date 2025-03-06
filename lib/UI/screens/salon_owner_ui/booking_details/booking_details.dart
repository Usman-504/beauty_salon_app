// import 'package:beauty_salon/UI/components/snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/constants/const_colors.dart';
// import '../../../../core/constants/const_styles.dart';
// import '../../../components/custom_button.dart';
// import '../../User_ui/bookings/booking_provider.dart';
// import '../../User_ui/bottom_nav_bar/book_appointment/book_appointment_provider.dart';
//
// class BookingDetails extends StatefulWidget {
//   BookingDetails(
//       {required this.serviceName,
//         required this.servicePrice,
//         required this.totalPrice,
//         required this.time,
//         required this.date,
//         required this.serviceType,
//         required this.imageUrl,
//         required this.customerName,
//         required this.customerAddress,
//         required this.customerNumber,
//         required this.customerMessage,
//
//         super.key});
//
//   String serviceName;
//   String customerName;
//   String customerNumber;
//   String customerAddress;
//   String customerMessage;
//   int servicePrice;
//   int totalPrice;
//   String date;
//   String time;
//   String serviceType;
//   String imageUrl;
//
//   @override
//   State<BookingDetails> createState() => _BookingDetailsState();
// }
//
// class _BookingDetailsState extends State<BookingDetails> {
//
//
//
//
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var heightX = MediaQuery.of(context).size.height;
//     var widthX = MediaQuery.of(context).size.width;
//     final bookingProvider = Provider.of<BookingProvider>(context);
//     final bookAppointmentProvider = Provider.of<BookAppointmentProvider>(context);
//     return Scaffold(
//       backgroundColor: kScaffoldColor,
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back,
//               size: heightX * 0.04,
//               color: kWhiteColor,
//             )),
//         centerTitle: true,
//         title: Text('Booking Details',
//             style: secondaryTextStyle.copyWith(
//                 color: kWhiteColor, fontSize: widthX * 0.063)),
//       ),
//       body: Column(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: heightX * 0.02,
//                     bottom: heightX * 0.01,
//                     left: widthX * 0.04,
//                     right: widthX * 0.04,
//                   ),
//                   child: Text(
//                     'Customer Details:',
//                     style: mediumTextStyle.copyWith(color: kPrimaryColor),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Customer Name',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.customerName,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Customer Number',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.customerNumber,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Customer Address',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.customerAddress,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Customer Message',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.customerMessage,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: heightX * 0.04,
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Text(
//                     'Appointment Details:',
//                     style: mediumTextStyle.copyWith(color: kPrimaryColor),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Service Name',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.serviceName,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Service Price',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         'Rs. ${widget.servicePrice }/-',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Date',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.date,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Time',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.time,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Service Type',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         widget.serviceType,
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
//                   child: const Divider(),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Sub Total',
//                         style: mediumTextStyle.copyWith(color: kPrimaryColor),
//                       ),
//                       Text(
//                         'Rs. ${widget.servicePrice}/-',
//                         style: mediumTextStyle.copyWith(color: kPrimaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'GST',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                       Text(
//                         'Rs. ${bookAppointmentProvider.gstPrice}/-',
//                         style: mediumTextStyle.copyWith(color: kSecondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
//                   child: const Divider(),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: heightX * 0.01,
//                       left: widthX * 0.04,
//                       right: widthX * 0.04),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Total',
//                         style: mediumTextStyle.copyWith(color: kPrimaryColor),
//                       ),
//                       Text(
//                         'Rs. ${widget.totalPrice}/-',
//                         style: mediumTextStyle.copyWith(color: kPrimaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: heightX* 0.02),
//             child: CustomButton(
//               height: heightX * 0.06,
//               width: widthX * 0.9,
//               text: 'Confirm Appointment',
//               onPress: () {
//                 bookAppointmentProvider.appointment(widget.serviceName, widget.servicePrice, widget.date, widget.time, widget.serviceType, bookAppointmentProvider.totalPrice, widget.imageUrl);
//                 // checkoutDetailsMap['serviceName'] = widget.serviceName;
//                 // checkoutDetailsMap['date'] = widget.date;
//                 // checkoutDetailsMap['serviceType'] = widget.serviceType;
//                 // checkoutDetailsMap['totalPrice'] = totalPrice;
//                 // checkoutDetailsMap['image'] = widget.imageUrl;
//                 // print(checkoutDetailsMap);
//                 // if (!bookingProvider.bookingList.any((element) => mapEquals(element, checkoutDetailsMap))) {
//                 //   bookingProvider.addItem(checkoutDetailsMap);
//                 // }
//                 // bookingProvider.bookingList.contains(checkoutDetailsMap) ? null :
//                 // bookingProvider.addItem(checkoutDetailsMap);
//                 Utils().orderCompleted(context);
//               },
//               borderRadius: heightX * 0.013,
//               style: mediumTextStyle.copyWith(fontSize: widthX * 0.045),
//               btnColor: kPrimaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }