
import 'package:beauty_salon/UI/components/side_drawer.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/profile_screen/profile_screen.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:flutter/material.dart';
import '../screens/data.dart';

import 'custom_textfield.dart';
import 'filter_icon.dart';

class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Header({
required this.scaffoldKey,
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
          color: kWhiteColor,
        ),
        Positioned(
          top: heightX * 0.075,
          left: widthX * 0.05,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Image.asset(
                  Assets.menuIcon,
                  color: kPrimaryColor,
                  height: heightX * 0.04,
                ),
              ),
              SizedBox(
                width: widthX * 0.03,
              ),
              Text(
                'Hi There',
                style: mediumTextStyle.copyWith(
                    fontSize: heightX * 0.027, color: kPrimaryColor),
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
            backgroundColor: kSecondaryColor,
          ),
        ),
        Positioned(
          left: widthX * 0.82,
          top: heightX * 0.067,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
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

