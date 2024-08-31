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
  List<String> images = [
    Assets.visaCard,
    Assets.masterCard,
    Assets.unionPayCard
  ];

  List<Color> borderColors = [Colors.blue, Colors.orange, Colors.red];

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
                  color: kButtonColor,
                  Assets.tickIcon,
                  height: MediaQuery.of(context).size.height * 0.13,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Text(
                      'Congratulations!',
                      style: primaryTextStyle.copyWith(color: kButtonColor),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Your reservation has been\nsuccessfully booked.',
                      style: smallTextStyle,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.025,
                // ),
                CustomButton(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  text: 'See Bookings',
                  onPress: () {



                    // checkoutDetailsList.add({
                    //   'serviceName': widget.serviceName,
                    //   'date': widget.date,
                    //   'serviceType': widget.serviceType,
                    //   'totalPrice': totalPrice,
                    //   'image': widget.imageUrl,
                    // });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  BookingScreen(bookingDetails: checkoutDetailsMap,)));
                  },
                  borderRadius: MediaQuery.of(context).size.height * 0.013,
                  style: mediumTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.052),
                  btnColor: kButtonColor,
                ),
              ],
            ),
          );
        });
  }

  void _addCard() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kContainerColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.close,
                        color: kButtonColor,
                      ),
                      Text(
                        'Add New Card',
                        style: mediumTextStyle.copyWith(color: kButtonColor),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Name on Card',
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.06),
                            hintStyle: smallTextStyle.copyWith(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: kButtonColor)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: kButtonColor))),
                      ),
                      CustomButton(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.7,
                        text: 'Add Card',
                        onPress: () {},
                        borderRadius:
                            MediaQuery.of(context).size.height * 0.013,
                        style: mediumTextStyle.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.052),
                        btnColor: kButtonColor,
                      ),
                    ],
                  ),
                ),
              ),
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
      appBar: AppBar(
        backgroundColor: kButtonColor,
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
              'Payment Details',
              style: mediumTextStyle.copyWith(color: kButtonColor),
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
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  widget.serviceName,
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
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
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  'Rs. ${widget.servicePrice }/-',
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
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
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  widget.date,
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
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
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  widget.time,
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
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
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  widget.serviceType,
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
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
                  style: mediumTextStyle.copyWith(color: kButtonColor),
                ),
                Text(
                  'Rs. ${widget.servicePrice}/-',
                  style: mediumTextStyle.copyWith(color: kButtonColor),
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
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  'Rs. $gstPrice/-',
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
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
                  style: mediumTextStyle.copyWith(color: kButtonColor),
                ),
                Text(
                 'Rs. $totalPrice/-',
                  style: mediumTextStyle.copyWith(color: kButtonColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: heightX * 0.03,
                bottom: heightX * 0.01,
                left: widthX * 0.04,
                right: widthX * 0.04),
            child: Text(
              'Select Card',
              style: mediumTextStyle.copyWith(color: kButtonColor),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _addCard();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: borderColors[index]),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Image.asset(
                          images[index],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, right: widthX * 0.04),
            child: CustomButton(
              height: heightX * 0.06,
              width: widthX * 0.9,
              text: 'Pay Now',
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
              btnColor: kButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
