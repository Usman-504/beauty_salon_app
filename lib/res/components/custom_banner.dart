import 'package:flutter/material.dart';
import '../../UI/screens/User_ui/bottom_nav_bar/services/all_services/all_services.dart';
import '../../res/colors.dart';
import '../../utils/styles.dart';
import '../../utils/assets.dart';
import 'custom_button.dart';

class CustomBanner extends StatelessWidget {

  const CustomBanner({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: heightX * 0.15,
        ),
        Container(
          height: heightX * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
          ),
        ),
        Positioned(
          top: heightX * 0.015,
          left: widthX * 0.02,
          child: Text(
            'Look more beautiful and\nSave more discount.',
            style:
            smallTextStyle.copyWith(color: AppColors.whiteColor),
          ),
        ),
        Positioned(
          top: heightX * 0.09,
          left: widthX * 0.02,
          child: CustomButton(
            height: heightX * 0.05,
            width: widthX * 0.4,
            text: 'Get offer now!',
            borderRadius: 10,
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const AllServices()));
            },
            style:
            smallTextStyle.copyWith(color: AppColors.whiteColor),
            btnColor: AppColors.primaryColor,
          ),
        ),
        Positioned(
          left: widthX * 0.7,
          // right: widthX * 0.002,
          child: Container(
            height: heightX * 0.25,
            width: widthX * 0.25,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: heightX * 0.2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      // fit: BoxFit.cover,
                        image: AssetImage( Assets.homeScreenPic))
                ),

              ),
            ),
          ),
        ),
        // Positioned(
        //   //  top: heightX * 0.2,
        //    //left: widthX * 0.2,
        //     child: Container(
        //       height: heightX * 0.15,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //            // fit: BoxFit.cover,
        //             image: AssetImage( Assets.homeScreenPic))
        //       ),
        //       // child: Image.asset(
        //       //   Assets.homeScreenPic,
        //       //   fit: BoxFit.cover,
        //       // ),
        //     )),
      ],
    );
  }
}