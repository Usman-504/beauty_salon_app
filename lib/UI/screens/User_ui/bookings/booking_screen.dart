import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../generated/assets.dart';
import '../../../components/custom_button.dart';
import '../bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import '../bottom_nav_bar/services/all_services/all_services.dart';
import 'booking_provider.dart';
import 'cancel_booking.dart';

class BookingScreen extends StatefulWidget {
   BookingScreen({required this.bookingDetails, super.key});

  Map<String, dynamic> bookingDetails = {};

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    final bookingProvider = Provider.of<BookingProvider>(context);
    return Scaffold(
      backgroundColor: kContainerColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const BottomNavBar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('All Bookings',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: widthX * 0.062)),
      ),
      body: bookingProvider.bookingList.isEmpty ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.emptyBooking, height: heightX * 0.35, ),
              Text(
                'No booking yet',
                style: primaryTextStyle.copyWith(
                    color: kPrimaryColor, fontSize: widthX * 0.085),
              ),
              Text(textAlign: TextAlign.center,
                'When you book an service you can find your booking details here.',
                style: smallTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontSize: widthX * 0.042,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: heightX * 0.03,
              ),

              CustomButton(height: heightX * 0.06, width: widthX * 0.7, text: 'Add Service', borderRadius: 10, onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AllServices()));
              }, style: mediumTextStyle, btnColor: kPrimaryColor,)
            ],
          ),
        ),
      ) :

      Column(
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
              style: mediumTextStyle.copyWith(color: kPrimaryColor),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: bookingProvider.bookingList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.all(widthX * 0.03 ),
                  child: Container(
                    height: heightX * 0.12,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
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
                                image:  DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        bookingProvider.bookingList[index] ['image']))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bookingProvider.bookingList[index]['serviceName'],
                                style: mediumTextStyle.copyWith(
                                    color: kPrimaryColor),
                              ),
                              Text(
                                bookingProvider.bookingList[index]['serviceType'],
                                style: smallTextStyle.copyWith(
                                    color: kPrimaryColor),
                              ),
                              Text(
                                bookingProvider.bookingList[index]['date'],
                                style: smallTextStyle.copyWith(
                                    color: kPrimaryColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CancelBooking(title: bookingProvider.bookingList[index]['serviceName'], price: 'Rs. ${bookingProvider.bookingList[index]['totalPrice']}/-', imageUrl: bookingProvider.bookingList[index] ['image'], date: bookingProvider.bookingList[index]['date'], )));
                                  },
                                  child: const Icon(Icons.more_vert)),
                              Text(
                                'Rs. ${bookingProvider.bookingList[index]['totalPrice']}/-',
                                style: smallTextStyle.copyWith(
                                    color: kPrimaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: heightX * 0.02,
          //       bottom: heightX * 0.01,
          //       left: widthX * 0.04,
          //       right: widthX * 0.04),
          //   child: Text(
          //     'Previous Bookings',
          //     style: mediumTextStyle.copyWith(color: kButtonColor),
          //   ),
          // ),
          // Padding(
          //   padding:  EdgeInsets.all(widthX * 0.03 ),
          //   child: Container(
          //     height: heightX * 0.12,
          //     decoration: BoxDecoration(
          //       color: kCircleAvatorColor,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.all(widthX * 0.03 ),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Container(
          //             height: heightX * 0.1,
          //             width: widthX * 0.2,
          //             decoration: BoxDecoration(
          //                 borderRadius:
          //                 BorderRadius.circular(10),
          //                 image: const DecorationImage(
          //                     fit: BoxFit.cover,
          //                     image: AssetImage(
          //                         Assets.classicManicureImage))),
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 'Classic Manicure',
          //                 style: mediumTextStyle.copyWith(
          //                     color: kButtonColor),
          //               ),
          //               Text(
          //                 'Salon',
          //                 style: smallTextStyle.copyWith(
          //                     color: kButtonColor),
          //               ),
          //               Text(
          //                 'Sat, 22/10/2024',
          //                 style: smallTextStyle.copyWith(
          //                     color: kButtonColor),
          //               ),
          //             ],
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Icon(Icons.more_vert),
          //               Text(
          //                 '1798/- Rs',
          //                 style: smallTextStyle.copyWith(
          //                     color: kButtonColor),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
         

        ],
      ),
    );
  }
}
