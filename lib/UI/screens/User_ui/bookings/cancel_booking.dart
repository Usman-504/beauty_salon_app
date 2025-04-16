import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/colors.dart';
import '../../../components/image_container.dart';
import 'booking_provider.dart';


class CancelBooking extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String docId;
  final int price;
  final String date;
  final String time;
  const CancelBooking(
      {
        required this.imageUrl,
        required this.title,
        required this.price,
        required this.date,
        required this.time,
        required this.docId,
        super.key});



  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.containerColor,
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
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(heightX * 0.03)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
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
                          color: AppColors.primaryColor, fontSize: widthX * 0.062),
                    ),
                    Text(
                      'Rs. $price/-',
                      style: smallTextStyle.copyWith(color: AppColors.secondaryColor),
                    ),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    Text(date,style: primaryTextStyle.copyWith(color: AppColors.primaryColor),),
                    Text(time,style: smallTextStyle.copyWith(color: AppColors.primaryColor),),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    CustomButton(height: heightX * 0.07, width: widthX * 0.9, text: 'Cancel Booking', borderRadius: 10, onPress: (){
                      bookingProvider.cancelBooking(docId);
                     //bookingProvider.deleteItem(title);
                      Navigator.pop(context);


                    }, style: mediumTextStyle, btnColor: AppColors.primaryColor,)
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