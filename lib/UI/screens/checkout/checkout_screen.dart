import 'package:beauty_salon/UI/screens/bookings/booking_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/const_colors.dart';
import '../../../core/constants/const_styles.dart';
import '../../../generated/assets.dart';
import '../../components/custom_button.dart';
import '../bookings/booking_provider.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen(
      {required this.serviceName,
      required this.servicePrice,
      required this.time,
      required this.date,
        required this.serviceType,
        required this.imageUrl,

      super.key});

  String serviceName;
  int servicePrice;
  String date;
  String time;
  String serviceType;
  String imageUrl;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {


  int gstPrice = 49;

  int get totalPrice => widget.servicePrice + gstPrice;

  Map<String, dynamic> checkoutDetailsMap = {};



  void _orderCompleted() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: kContainerColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  color: kPrimaryColor,
                  Assets.tickIcon,
                  height: MediaQuery.of(context).size.height * 0.13,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Text(
                      'Congratulations!',
                      style: primaryTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Your reservation has been\nsuccessfully booked.',
                      style: smallTextStyle,
                    ),
                  ],
                ),

                CustomButton(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  text: 'See Bookings',
                  onPress: () {




                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  BookingScreen(bookingDetails: checkoutDetailsMap,)));
                  },
                  borderRadius: MediaQuery.of(context).size.height * 0.013,
                  style: mediumTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.052),
                  btnColor: kPrimaryColor,
                ),
              ],
            ),
          );
        });
  }





  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final bookingProvider = Provider.of<BookingProvider>(context);
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
        title: Text('Summary',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: heightX * 0.03)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: heightX * 0.02,
                bottom: heightX * 0.01,
                left: widthX * 0.04,
                right: widthX * 0.04),
            child: Text(
              'Appointment Details',
              style: mediumTextStyle.copyWith(color: kPrimaryColor),
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
                  'Service Name',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
                ),
                Text(
                  widget.serviceName,
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
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
                  'Service Price',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
                ),
                Text(
                  'Rs. ${widget.servicePrice }/-',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
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
                  'Date',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
                ),
                Text(
                  widget.date,
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
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
                  'Time',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
                ),
                Text(
                  widget.time,
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
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
                  'Service Type',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
                ),
                Text(
                  widget.serviceType,
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
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
                  'Sub Total',
                  style: mediumTextStyle.copyWith(color: kPrimaryColor),
                ),
                Text(
                  'Rs. ${widget.servicePrice}/-',
                  style: mediumTextStyle.copyWith(color: kPrimaryColor),
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
                  'GST',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
                ),
                Text(
                  'Rs. $gstPrice/-',
                  style: mediumTextStyle.copyWith(color: kSecondaryColor),
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
                  'Total',
                  style: mediumTextStyle.copyWith(color: kPrimaryColor),
                ),
                Text(
                 'Rs. $totalPrice/-',
                  style: mediumTextStyle.copyWith(color: kPrimaryColor),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
            child: CustomButton(
              height: heightX * 0.06,
              width: widthX * 0.9,
              text: 'Confirm Appointment',
              onPress: () {
                checkoutDetailsMap['serviceName'] = widget.serviceName;
                checkoutDetailsMap['date'] = widget.date;
                checkoutDetailsMap['serviceType'] = widget.serviceType;
                checkoutDetailsMap['totalPrice'] = totalPrice;
                checkoutDetailsMap['image'] = widget.imageUrl;
                print(checkoutDetailsMap);
                if (!bookingProvider.bookingList.any((element) => mapEquals(element, checkoutDetailsMap))) {
                  bookingProvider.addItem(checkoutDetailsMap);
                }
                // bookingProvider.bookingList.contains(checkoutDetailsMap) ? null :
                // bookingProvider.addItem(checkoutDetailsMap);
                _orderCompleted();
              },
              borderRadius: heightX * 0.013,
              style: mediumTextStyle.copyWith(fontSize: heightX * 0.022),
              btnColor: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
