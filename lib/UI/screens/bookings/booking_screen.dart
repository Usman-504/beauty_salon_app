import 'package:flutter/material.dart';

import '../../../core/constants/const_colors.dart';
import '../../../core/constants/const_styles.dart';
import '../../../generated/assets.dart';
import 'cancel_booking.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kContainerColor,
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
        title: Text('All Bookings',
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
              'Upcoming Bookings',
              style: mediumTextStyle.copyWith(color: kButtonColor),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(widthX * 0.03 ),
            child: Container(
              height: heightX * 0.12,
              decoration: BoxDecoration(
                color: kCircleAvatorColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(widthX * 0.03 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: heightX * 0.1,
                      width: widthX * 0.2,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  Assets.classicManicureImage))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Classic Manicure',
                          style: mediumTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Salon',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Sat, 22/10/2024',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CancelBooking()));},
                            child: Icon(Icons.more_vert)),
                        Text(
                          '1798/- Rs',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(widthX * 0.03 ),
            child: Container(
              height: heightX * 0.12,
              decoration: BoxDecoration(
                color: kCircleAvatorColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(widthX * 0.03 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: heightX * 0.1,
                      width: widthX * 0.2,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  Assets.classicManicureImage))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Classic Manicure',
                          style: mediumTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Home',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Sat, 22/10/2024',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.more_vert),
                        Text(
                          '1798/- Rs',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: heightX * 0.02,
                bottom: heightX * 0.01,
                left: widthX * 0.04,
                right: widthX * 0.04),
            child: Text(
              'Previous Bookings',
              style: mediumTextStyle.copyWith(color: kButtonColor),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(widthX * 0.03 ),
            child: Container(
              height: heightX * 0.12,
              decoration: BoxDecoration(
                color: kCircleAvatorColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(widthX * 0.03 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: heightX * 0.1,
                      width: widthX * 0.2,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  Assets.classicManicureImage))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Classic Manicure',
                          style: mediumTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Salon',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Sat, 22/10/2024',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.more_vert),
                        Text(
                          '1798/- Rs',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(widthX * 0.03 ),
            child: Container(
              height: heightX * 0.12,
              decoration: BoxDecoration(
                color: kCircleAvatorColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(widthX * 0.03 ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: heightX * 0.1,
                      width: widthX * 0.2,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  Assets.classicManicureImage))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Classic Manicure',
                          style: mediumTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Home',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                        Text(
                          'Sat, 22/10/2024',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.more_vert),
                        Text(
                          '1798/- Rs',
                          style: smallTextStyle.copyWith(
                              color: kButtonColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
