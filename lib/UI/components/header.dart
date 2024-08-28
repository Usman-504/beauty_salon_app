import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:flutter/material.dart';
import '../screens/data.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import 'custom_textfield.dart';
import 'filter_icon.dart';

class Header extends StatelessWidget {
  const Header({

    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: heightX * 0.25,
          color: kContainerColor,
        ),
        Positioned(
          top: heightX * 0.075,
          left: widthX * 0.05,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const OnboardingScreen()));
                },
                child: Image.asset(
                  Assets.menuIcon,
                  color: kButtonColor,
                  height: heightX * 0.04,
                ),
              ),
              SizedBox(
                width: widthX * 0.03,
              ),
              Text(
                'Hi There',
                style: mediumTextStyle.copyWith(
                    fontSize: heightX * 0.027, color: kButtonColor),
              ),
              SizedBox(
                width: widthX * 0.4,
              ),
            ],
          ),
        ),
        Positioned(
          left: widthX * 0.81,
          top: heightX * 0.062,
          child: CircleAvatar(
            radius: heightX * 0.03,
            backgroundColor: kCircleAvatorColor,
          ),
        ),
        Positioned(
          left: widthX * 0.82,
          top: heightX * 0.067,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Data()));
            },
            child: CircleAvatar(
              radius: heightX * 0.025,
              backgroundImage: const AssetImage(Assets.dp),
            ),
          ),
        ),
        Positioned(
          top: heightX * 0.15,
          child: CustomTextField(
            hintText: 'Find Services',
            maxWidth: widthX * 0.75,
            maxHeight: heightX * 0.065,
            prefix: const Icon(Icons.search),
          ),
        ),
        const ShoppingCart(),
      ],
    );
  }
}

