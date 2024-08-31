import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../components/image_container.dart';


class CancelBooking extends StatelessWidget {
  const CancelBooking(
      {

        super.key});



  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    void showSnackBar(String message, Function() onPress, String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: smallTextStyle,
          ),
          action: SnackBarAction(
            label: text,
            onPressed: onPress,
            textColor: kButtonColor,
          ),
          backgroundColor: kCircleAvatorColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: kContainerColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
          ),
          ImageContainer(
            height: heightX * 0.6,
            imageUrl: Assets.classicManicureImage,
          ),
          Positioned(
              top: heightX * 0.05,
              left: widthX * 0.03,
              child: Container(
                  height: heightX * 0.047,
                  width: widthX * 0.1,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(heightX * 0.03)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: kButtonColor,
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
                      'Classic Manicure',
                      style: mediumTextStyle.copyWith(
                          color: kButtonColor, fontSize: heightX * 0.03),
                    ),
                    Text(
                      '2499',
                      style: smallTextStyle.copyWith(color: kCircleAvatorColor),
                    ),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    Text('22 October 2024',style: primaryTextStyle.copyWith(color: kButtonColor),),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    CustomButton(height: heightX * 0.07, width: widthX * 0.9, text: 'Cancel Booking', borderRadius: 10, onPress: (){}, style: mediumTextStyle, btnColor: kButtonColor,)
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