import 'package:beauty_salon/UI/screens/bookings/booking_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/const_colors.dart';
import '../../../core/constants/const_styles.dart';
import '../../../generated/assets.dart';
import '../../components/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

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

  void _orderCompleted() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration:   const BoxDecoration(
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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.015,
                    // ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingScreen()));
                  },
                  borderRadius: MediaQuery.of(context).size.height * 0.013,
                  style: mediumTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * 0.052),
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
            decoration:   const BoxDecoration(
                color: kContainerColor,
            ),
            child: Padding(
              padding:  const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.close, color: kButtonColor,),
                      Text(
                        'Add New Card',
                        style: mediumTextStyle.copyWith(color: kButtonColor),
                      ),

                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Name on Card',
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9, maxHeight: MediaQuery.of(context).size.height* 0.06),
                            hintStyle: smallTextStyle.copyWith(color: Colors.grey, fontSize: MediaQuery.of(context).size.height  * 0.02),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 2, color: kButtonColor)
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(width: 2, color: kButtonColor)
                          )
                        ),
                      ),
                      CustomButton(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.7,
                        text: 'Add Card',
                        onPress: () {},
                        borderRadius: MediaQuery.of(context).size.height * 0.013,
                        style: mediumTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * 0.052),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
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
                  'Classic Manicure',
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  '1749/- Rs',
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
                  '22/10/2024',
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
                  '11:00 Am',
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
                  'Stylist',
                  style: mediumTextStyle.copyWith(color: kCircleAvatorColor),
                ),
                Text(
                  'Mahnoor',
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
                  'Home',
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
                  '1749/- Rs',
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
                  '49/- Rs',
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
                  '1798/- Rs',
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
                      onTap: (){
                        _addCard();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: borderColors[index]),
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
                _orderCompleted();
              },
              borderRadius: heightX * 0.013,
              style: mediumTextStyle.copyWith(fontSize: heightX * 0.022),
            ),
          ),
        ],
      ),
    );
  }
}
