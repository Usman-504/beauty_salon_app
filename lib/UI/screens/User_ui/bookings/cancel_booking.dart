import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../components/image_container.dart';
import 'booking_provider.dart';


class CancelBooking extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String price;
  final String date;
  const CancelBooking(
      {
        required this.imageUrl,
        required this.title,
        required this.price,
        required this.date,
        super.key});



  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      backgroundColor: kContainerColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
          ),
          ImageContainer(
            height: heightX * 0.6,
            imageUrl: imageUrl,
          ),
          Positioned(
              top: heightX * 0.05,
              left: widthX * 0.03,
              child: Container(
                  height: heightX * 0.047,
                  width: widthX * 0.1,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(heightX * 0.03)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                      )))),
          Positioned(
            left: widthX * 0.05,
            top: heightX * 0.58,
            child: WhiteContainer(
              height: heightX * 0.35,
              width: widthX * 0.9,
              child: Padding(
                padding:
                EdgeInsets.only(left: widthX * 0.05, right: widthX * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    Text(
                      title,
                      style: mediumTextStyle.copyWith(
                          color: kPrimaryColor, fontSize: widthX * 0.062),
                    ),
                    Text(
                      price,
                      style: smallTextStyle.copyWith(color: kSecondaryColor),
                    ),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    Text(date,style: primaryTextStyle.copyWith(color: kPrimaryColor),),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    CustomButton(height: heightX * 0.07, width: widthX * 0.9, text: 'Cancel Booking', borderRadius: 10, onPress: (){
                      bookingProvider.deleteItem(title);
                      Navigator.pop(context);


                    }, style: mediumTextStyle, btnColor: kPrimaryColor,)
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