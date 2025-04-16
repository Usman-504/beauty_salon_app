import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/snackbar.dart';
import '../../utils/styles.dart';
import '../../view_model/user_view_model/booking_provider.dart';
import '../../view_model/user_view_model/book_appointment_provider.dart';

class AppointmentSummary extends StatefulWidget {
  const AppointmentSummary(
      {this.serviceName,
        this.appointment = false,
      this.servicePrice,
      required this.totalPrice,
      this.time,
      required this.date,
      required this.serviceType,
      this.imageUrl,
      required this.customerName,
      required this.customerAddress,
      required this.customerNumber,
      required this.customerMessage,
      required this.appointmentStatus,
      required this.docId,
      this.cart = false,
      super.key,
      this.serviceNames,
      this.servicePrices,
      this.imageUrls,
      this.timeSlots,
      this.cartLength});

  final String? serviceName;
  final List? serviceNames;
  final String customerName;
  final String customerNumber;
  final String customerAddress;
  final String customerMessage;
  final String docId;
  final int? servicePrice;
  final List? servicePrices;
  final int totalPrice;
  final String date;
  final String? time;
  final List? timeSlots;
  final String appointmentStatus;
  final String serviceType;
  final List? imageUrls;
  final String? imageUrl;
  final bool cart;
  final bool appointment;
  final int? cartLength;

  @override
  State<AppointmentSummary> createState() => _AppointmentSummaryState();
}

class _AppointmentSummaryState extends State<AppointmentSummary> {
  @override
  void initState() {
    Future.microtask(() => (context).read<BookAppointmentProvider>().getRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final bookingProvider = Provider.of<BookingProvider>(context);
    final bookAppointmentProvider =
        Provider.of<BookAppointmentProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: AppColors.whiteColor,
            )),
        centerTitle: true,
        title: Text(
            bookAppointmentProvider.role == 'salon owner'
                ? 'Booking Details'
                : widget.appointmentStatus.isEmpty
                    ? 'Summary'
                    : 'Booking Details',
            style: secondaryTextStyle.copyWith(
                color: AppColors.whiteColor, fontSize: widthX * 0.063)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        widget.customerName,
                        overflow: TextOverflow.ellipsis,
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        widget.customerNumber,
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        // textAlign: TextAlign.justify,
                        widget.customerAddress,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        // textAlign: TextAlign.justify,

                        widget.customerMessage.isEmpty
                            ? 'Nil'
                            : widget.customerMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                if (widget.cart)
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
                          'No Of Services:',
                          style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                        ),
                        Text(
                          // textAlign: TextAlign.justify,

                          widget.cartLength.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: smallTextStyle.copyWith(
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthX * 0.04, right: widthX * 0.04),
                  child: const Divider(),
                ),
                if (!widget.cart)
                  Column(
                    children: [
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
                              style:
                                  smallTextStyle.copyWith(color: AppColors.primaryColor),
                            ),
                            Text(
                              widget.serviceName!,
                              style: smallTextStyle.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.normal),
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
                              style:
                                  smallTextStyle.copyWith(color: AppColors.primaryColor),
                            ),
                            Text(
                              'Rs. ${widget.servicePrice}/-',
                              style: smallTextStyle.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.normal),
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
                              style:
                                  smallTextStyle.copyWith(color: AppColors.primaryColor),
                            ),
                            Text(
                              widget.time!,
                              style: smallTextStyle.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (widget.cart)
                  Column(
                    children:
                        List.generate(widget.serviceNames!.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: heightX * 0.01,
                          left: widthX * 0.04,
                          right: widthX * 0.04,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service Name:',
                                  style: smallTextStyle.copyWith(
                                      color: AppColors.primaryColor),
                                ),
                                Text(
                                  widget.serviceNames![index],
                                  style: smallTextStyle.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: heightX * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Service Price:',
                                    style: smallTextStyle.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                  Text(
                                    'Rs. ${widget.servicePrices![index]}/-',
                                    style: smallTextStyle.copyWith(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Appointment Time:',
                                  style: smallTextStyle.copyWith(
                                      color: AppColors.primaryColor),
                                ),
                                Text(
                                  widget.timeSlots![index],
                                  style: smallTextStyle.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                // Column(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //           bottom: heightX * 0.01,
                //           left: widthX * 0.04,
                //           right: widthX * 0.04),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Service Name:',
                //             style: smallTextStyle.copyWith(color: kPrimaryColor),
                //           ),
                //           Text(
                //             '',
                //             style:smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(
                //           bottom: heightX * 0.01,
                //           left: widthX * 0.04,
                //           right: widthX * 0.04),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Service Price:',
                //             style: smallTextStyle.copyWith(color: kPrimaryColor),
                //           ),
                //           Text(
                //             '',
                //             style: smallTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.normal),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(
                //           bottom: heightX * 0.01,
                //           left: widthX * 0.04,
                //           right: widthX * 0.04),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Appointment Time:',
                //             style: smallTextStyle.copyWith(color: kPrimaryColor),
                //           ),
                //           Text(
                //             '',
                //             style: smallTextStyle.copyWith(color: kSecondaryColor,   fontWeight: FontWeight.normal),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        widget.date,
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        widget.serviceType,
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                widget.appointmentStatus.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(
                            bottom: heightX * 0.01,
                            left: widthX * 0.04,
                            right: widthX * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Appointment Status:',
                              style:
                                  smallTextStyle.copyWith(color: AppColors.primaryColor),
                            ),
                            Text(
                              widget.appointmentStatus,
                              style: smallTextStyle.copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthX * 0.04, right: widthX * 0.04),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        'Rs. ${!widget.cart ? widget.servicePrice : widget.servicePrices!.fold<int>(0, (sum, price) => sum + (price as int))}/-',
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        'Rs. ${bookAppointmentProvider.gstPrice}/-',
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: widthX * 0.04, right: widthX * 0.04),
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
                        style: smallTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                      Text(
                        'Rs. ${widget.totalPrice}/-',
                        style: smallTextStyle.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (bookAppointmentProvider.role == 'client' && !widget.appointment)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: CustomButton(
                  height: heightX * 0.06,
                  width: widthX * 0.9,
                  text: 'Make Payment',
                  onPress: () {
                    bookAppointmentProvider.paymentSheet(widget.totalPrice, 'PKR', context);
                  },
                  borderRadius: heightX * 0.013,
                  style: mediumTextStyle.copyWith(fontSize: widthX * 0.045),
                  btnColor: AppColors.primaryColor,),
              ),
            bookAppointmentProvider.role == 'salon owner'
                ? Padding(
                    padding: EdgeInsets.only(
                        left: widthX * 0.04,
                        right: widthX * 0.04,
                        bottom: heightX * 0.02),
                    child: CustomButton(
                      height: heightX * 0.06,
                      width: widthX * 0.9,
                      text: 'Accept Appointment',
                      onPress: () {
                        bookAppointmentProvider.acceptAppointment(
                            widget.docId, context);
                      },
                      borderRadius: heightX * 0.013,
                      style: mediumTextStyle.copyWith(fontSize: widthX * 0.045),
                      btnColor: AppColors.primaryColor,
                    ),
                  )
                : const SizedBox.shrink(),
            if (bookAppointmentProvider.role == 'salon owner')
              widget.appointmentStatus == 'Accepted' &&
                      widget.appointmentStatus == 'Rejected' &&
                      widget.appointmentStatus.isNotEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(
                          left: widthX * 0.04,
                          right: widthX * 0.04,
                          bottom: heightX * 0.02),
                      child: CustomButton(
                        height: heightX * 0.06,
                        width: widthX * 0.9,
                        text: bookAppointmentProvider.role == 'salon owner'
                            ? 'Reject Appointment'
                            : 'Confirm Appointment',
                        onPress: () {
                          print('object');
                          bookAppointmentProvider.role == 'salon owner'
                              ? bookAppointmentProvider.rejectAppointment(
                                  widget.docId, context)
                              : !widget.cart
                                  ? bookAppointmentProvider.appointment(
                                      widget.date,
                                      widget.serviceType,
                                      widget.totalPrice,
                                      widget.customerName,
                                      widget.customerNumber,
                                      widget.customerAddress,
                                      widget.customerMessage,
                                      context,
                                      serviceName: widget.serviceName!,
                                      servicePrice: widget.servicePrice!,
                                      appointmentTime: widget.time!,
                                      imageUrl: widget.imageUrl!)
                                  : bookAppointmentProvider.appointment(
                                      widget.date,
                                      widget.serviceType,
                                      widget.totalPrice,
                                      widget.customerName,
                                      widget.customerNumber,
                                      widget.customerAddress,
                                      widget.customerMessage,
                                      context,
                                      serviceNames: widget.serviceNames!,
                                      servicePrices: widget.servicePrices!,
                                      appointmentTimes: widget.timeSlots!,
                                      imageUrls: widget.imageUrls!);
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
                          bookAppointmentProvider.role == 'salon owner'
                              ? null
                              : Utils().orderCompleted(context);
                        },
                        borderRadius: heightX * 0.013,
                        style:
                            mediumTextStyle.copyWith(fontSize: widthX * 0.045),
                        btnColor: AppColors.primaryColor,
                      ),
                    ),
            if (bookAppointmentProvider.role == 'client')
              // widget.appointmentStatus == 'Accepted' ||
              //         widget.appointmentStatus == 'Rejected' &&
              //             widget.appointmentStatus.isNotEmpty
              widget.appointment
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(
                          left: widthX * 0.04,
                          right: widthX * 0.04,
                          bottom: heightX * 0.02),
                      child: CustomButton(
                        height: heightX * 0.06,
                        width: widthX * 0.9,
                        text: bookAppointmentProvider.role == 'salon owner'
                            ? 'Reject Appointment'

                                : 'Confirm Appointment',
                        onPress: () {


                          // if (widget.appointmentStatus == 'Pending') {
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return ShowAlertDialog(
                          //         message:
                          //             'Are you sure you want to cancel your booking?',
                          //         onPress: () {
                          //           bookingProvider.cancelBooking(widget.docId);
                          //           Navigator.pop(context);
                          //           Navigator.pushAndRemoveUntil(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     const BookingScreen()),
                          //             (route) => false,
                          //           );
                          //           Utils().showSnackBar(
                          //               context, 'Appointment Cancelled');
                          //         },
                          //       );
                          //     },
                          //   );
                          // } else {
                            if (!widget.cart) {
                              bookAppointmentProvider.appointment(
                                widget.date,
                                widget.serviceType,
                                widget.totalPrice,
                                widget.customerName,
                                widget.customerNumber,
                                widget.customerAddress,
                                widget.customerMessage,
                                context,
                                serviceName: widget.serviceName!,
                                servicePrice: widget.servicePrice!,
                                appointmentTime: widget.time!,
                                imageUrl: widget.imageUrl!,
                              );
                            } else {
                              bookAppointmentProvider.appointment(
                                widget.date,
                                widget.serviceType,
                                widget.totalPrice,
                                widget.customerName,
                                widget.customerNumber,
                                widget.customerAddress,
                                widget.customerMessage,
                                context,
                                serviceNames: widget.serviceNames!,
                                servicePrices: widget.servicePrices!,
                                appointmentTimes: widget.timeSlots!,
                                imageUrls: widget.imageUrls!,
                              );
                            }

                        },
                        // onPress: () {
                        //   bookAppointmentProvider.role == 'admin' ?  bookAppointmentProvider.rejectAppointment(widget.docId, context) :
                        //   widget.appointmentStatus == 'Pending' ?
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context){
                        //         return  ShowAlertDialog(message: 'Are you sure you want to cancel your booking?', onPress: () {   bookingProvider.cancelBooking(widget.docId); },);
                        //       })
                        //
                        //       :
                        //   bookAppointmentProvider.appointment(widget.serviceName, widget.servicePrice, widget.date, widget.time, widget.serviceType, bookAppointmentProvider.totalPrice, widget.imageUrl);
                        //   bookAppointmentProvider.role == 'admin' ? null :
                        //   widget.appointmentStatus == 'Pending' ?
                        //
                        //  { Navigator.pop(context),
                        //   Utils().showSnackBar(context, 'Appointment Cancelled')}
                        //
                        //       :
                        //   Utils().orderCompleted(context);
                        // },
                        borderRadius: heightX * 0.013,
                        style:
                            mediumTextStyle.copyWith(fontSize: widthX * 0.045),
                        btnColor: AppColors.primaryColor,
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
