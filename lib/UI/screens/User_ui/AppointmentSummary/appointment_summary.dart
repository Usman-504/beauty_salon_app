import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../generated/assets.dart';
import '../../../components/custom_button.dart';
import '../bookings/booking_provider.dart';
import '../bookings/booking_screen.dart';
import '../bottom_nav_bar/book_appointment/book_appointment_provider.dart';

class AppointmentSummary extends StatefulWidget {
  AppointmentSummary(
      {required this.serviceName,
      required this.servicePrice,
      required this.totalPrice,
      required this.time,
      required this.date,
        required this.serviceType,
        required this.imageUrl,
        required this.customerName,
        required this.customerAddress,
        required this.customerNumber,
        required this.customerMessage,
        required this.appointmentStatus,
        required this.docId,

      super.key});

  String serviceName;
  String customerName;
  String customerNumber;
  String customerAddress;
  String customerMessage;
  String docId;
  int servicePrice;
  int totalPrice;
  String date;
  String time;
  String appointmentStatus;
  String serviceType;
  String imageUrl;

  @override
  State<AppointmentSummary> createState() => _AppointmentSummaryState();
}

class _AppointmentSummaryState extends State<AppointmentSummary> {

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(()=>(context).read<BookAppointmentProvider>().getRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final bookingProvider = Provider.of<BookingProvider>(context);
    final bookAppointmentProvider = Provider.of<BookAppointmentProvider>(context);
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text(
            bookAppointmentProvider.role == 'admin' ? 'Booking Details' :
            widget.appointmentStatus.isEmpty ?
            'Summary' : 'Booking Details',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: widthX * 0.063)),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: heightX * 0.02,
                //       bottom: heightX * 0.01,
                //       left: widthX * 0.04,
                //       right: widthX * 0.04,
                //   ),
                //   child: Text(
                //     'Customer Details:',
                //     style: mediumTextStyle.copyWith(color: kPrimaryColor),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: heightX * 0.02,
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Name:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        widget.customerName,
                        overflow: TextOverflow.ellipsis,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Customer Number:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        widget.customerNumber,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthX * 0.05,
                      ),
                      Text(
                        'Customer Address:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                       // textAlign: TextAlign.justify,
                        widget.customerAddress,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthX * 0.05,
                      ),
                      Text(
                        'Customer Message:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                       // textAlign: TextAlign.justify,

                        widget.customerMessage.isEmpty ? 'Nil' : widget.customerMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: heightX * 0.04,
                //       bottom: heightX * 0.01,
                //       left: widthX * 0.04,
                //       right: widthX * 0.04),
                //   child: Text(
                //     'Appointment Details:',
                //     style: mediumTextStyle.copyWith(color: kPrimaryColor),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
                  child: const Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service Name:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        widget.serviceName,
                        style:smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service Price:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        'Rs. ${widget.servicePrice }/-',
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment Date:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        widget.date,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment Time:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        widget.time,
                        style: smallTextStyle.copyWith(color: kSecondaryColor,   fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service Type:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        widget.serviceType,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                widget.appointmentStatus.isEmpty ? SizedBox.shrink() :
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment Status:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                       widget.appointmentStatus,
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
                  child: const Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub Total:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        'Rs. ${widget.servicePrice}/-',
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GST:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        'Rs. ${bookAppointmentProvider.gstPrice}/-',
                        style:smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
                  child: const Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: heightX * 0.01,
                      left: widthX * 0.04,
                      right: widthX * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: smallTextStyle.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                       'Rs. ${widget.totalPrice}/-',
                        style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
         bookAppointmentProvider.role == 'admin' ? Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: heightX* 0.02),
            child: CustomButton(
              height: heightX * 0.06,
              width: widthX * 0.9,
              text: 'Accept Appointment',
              onPress: () {
                bookAppointmentProvider.acceptAppointment(widget.docId, context);
              },
              borderRadius: heightX * 0.013,
              style: mediumTextStyle.copyWith(fontSize: widthX * 0.045),
              btnColor: kPrimaryColor,
            ),
          ) : SizedBox.shrink(),
          if(bookAppointmentProvider.role == 'admin' )
          widget.appointmentStatus == 'Accepted' &&  widget.appointmentStatus == 'Rejected' && widget.appointmentStatus.isNotEmpty  ? SizedBox.shrink() :
          Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: heightX* 0.02),
            child: CustomButton(
              height: heightX * 0.06,
              width: widthX * 0.9,
              text: bookAppointmentProvider.role == 'admin' ? 'Reject Appointment' :
              'Confirm Appointment',
              onPress: () {
                bookAppointmentProvider.role == 'admin' ?  bookAppointmentProvider.rejectAppointment(widget.docId, context) :
                 bookAppointmentProvider.appointment(widget.serviceName, widget.servicePrice, widget.date, widget.time, widget.serviceType, bookAppointmentProvider.totalPrice, widget.imageUrl);
                // checkoutDetailsMap['serviceName'] = widget.serviceName;
                // checkoutDetailsMap['date'] = widget.date;
                // checkoutDetailsMap['serviceType'] = widget.serviceType;
                // checkoutDetailsMap['totalPrice'] = totalPrice;
                // checkoutDetailsMap['image'] = widget.imageUrl;
                // print(checkoutDetailsMap);
                // if (!bookingProvider.bookingList.any((element) => mapEquals(element, checkoutDetailsMap))) {
                //   bookingProvider.addItem(checkoutDetailsMap);
               // }
                // bookingProvider.bookingList.contains(checkoutDetailsMap) ? null :
                // bookingProvider.addItem(checkoutDetailsMap);
                bookAppointmentProvider.role == 'admin' ? null : Utils().orderCompleted(context);
              },
              borderRadius: heightX * 0.013,
              style: mediumTextStyle.copyWith(fontSize: widthX * 0.045),
              btnColor: kPrimaryColor,
            ),
          ),
          if(bookAppointmentProvider.role == 'client' )
            widget.appointmentStatus == 'Accepted' ||  widget.appointmentStatus == 'Rejected'   && widget.appointmentStatus.isNotEmpty  ? SizedBox.shrink() :
            Padding(
              padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04, bottom: heightX* 0.02),
              child: CustomButton(
                height: heightX * 0.06,
                width: widthX * 0.9,
                text: bookAppointmentProvider.role == 'admin' ? 'Reject Appointment' :
                widget.appointmentStatus == 'Pending' ? 'Cancel Appointment' :
                'Confirm Appointment',
                onPress: () {
                  bookAppointmentProvider.role == 'admin' ?  bookAppointmentProvider.rejectAppointment(widget.docId, context) :
                  widget.appointmentStatus == 'Pending' ?
                  bookingProvider.cancelBooking(widget.docId)
                      :
                  bookAppointmentProvider.appointment(widget.serviceName, widget.servicePrice, widget.date, widget.time, widget.serviceType, bookAppointmentProvider.totalPrice, widget.imageUrl);
                  bookAppointmentProvider.role == 'admin' ? null :
                  widget.appointmentStatus == 'Pending' ?

                 { Navigator.pop(context),
                  Utils().showSnackBar(context, 'Appointment Cancelled')}

                      :
                  Utils().orderCompleted(context);
                },
                borderRadius: heightX * 0.013,
                style: mediumTextStyle.copyWith(fontSize: widthX * 0.045),
                btnColor: kPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
