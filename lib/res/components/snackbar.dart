import  'package:flutter/material.dart';
import '../../view/user_view/booking_screen.dart';
import '../../res/colors.dart';
import '../../utils/styles.dart';
import '../../utils/assets.dart';
import 'custom_button.dart';

class Utils {
  void cartSnackBar(
      BuildContext context, String message, String text, VoidCallback onPress) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryColor,
        action: SnackBarAction(
            label: text, textColor: Colors.white, onPressed: onPress),
      ),
    );
  }

  void showSnackBar(
      BuildContext context, String message, ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
          const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }

  void orderCompleted(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  color: AppColors.primaryColor,
                  Assets.tickIcon,
                  height: MediaQuery.of(context).size.height * 0.13,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Text(
                      'Congratulations!',
                      style: primaryTextStyle.copyWith(color: AppColors.primaryColor),
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




                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const BookingScreen( )));
                  },
                  borderRadius: MediaQuery.of(context).size.height * 0.013,
                  style: mediumTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.052),
                  btnColor: AppColors.primaryColor,
                ),
              ],
            ),
          );
        });
  }

}
