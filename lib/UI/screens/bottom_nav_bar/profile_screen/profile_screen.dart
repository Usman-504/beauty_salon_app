import 'package:beauty_salon/UI/screens/auth/login_screen/login_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/profile_screen/edit_profile_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/profile_screen/privacy_screen.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../generated/assets.dart';
import 'about_us_screen.dart';
import 'change_password.dart';
import 'feedback_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<Map<String, dynamic>> info = [
    {
      'title': 'Change Password',
      'description': '',
      'icon': Icons.password,
      'staticIcon': Icons.arrow_forward_ios_rounded,
    },
    {
      'title': 'About Us',
      'description': 'Learn more about our app',
      'icon': Icons.info_outlined,
      'staticIcon': Icons.arrow_forward_ios_rounded,
    },
    {
      'title': 'Privacy',
      'description': 'Learn more about Privacy',
      'icon': Icons.privacy_tip,
      'staticIcon': Icons.arrow_forward_ios_rounded,
    },
    {
      'title': 'Send Feedback',
      'description': 'Send us valuable Feedback',
      'icon': Icons.message,
      'staticIcon': Icons.arrow_forward_ios_rounded,
    },
    {
      'title': 'Logout',
      'description': '',
      'icon': Icons.login_outlined,
      'staticIcon': Icons.arrow_forward_ios_rounded,
    },
  ];

  List<Widget> listTileScreens = [
    const ChangePasswordScreen(),
    const AboutUsScreen(),
    const PrivacyScreen(),
    const FeedbackScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kScaffoldColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const BottomNavBar()));
              },
              child: Icon(
                Icons.arrow_back,
                size: heightX * 0.04,
                color: kWhiteColor,
              )),
          centerTitle: true,
          title: Text('Profile',
              style: secondaryTextStyle.copyWith(
                  color: kWhiteColor, fontSize: heightX * 0.03)),
        ),
        body: Padding(
          padding: EdgeInsets.all(widthX * 0.03),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: heightX * 0.15,
                    decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Positioned(
                    top: heightX * 0.01,
                    left: widthX * 0.02,
                    child: Container(
                      height: heightX * 0.13,
                      width: heightX * 0.13,
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 3),
                          shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    top: heightX * 0.02,
                    left: widthX * 0.04,
                    child: Container(
                      height: heightX * 0.11,
                      width: heightX * 0.11,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.dp)),
                          shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                      top: heightX * 0.04,
                      left: widthX * 0.32,
                      child: Text(
                        'Mahnoor',
                        style: secondaryTextStyle.copyWith(color: kPrimaryColor),
                      )),
                  Positioned(
                    top: heightX * 0.075,
                    left: widthX * 0.32,
                    child: Text(
                      'Mahnoor123@gmail.com',
                      style: smallTextStyle,
                    ),
                  ),
                  Positioned(
                      top: heightX * 0.04,
                      left: widthX * 0.83,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
                        },
                          child: const Icon(
                        Icons.edit,
                        color: kPrimaryColor,
                      ))),
                ],
              ),
              SizedBox(
                height: heightX * 0.03,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: info.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: heightX * 0.02,
                        ),
                        child: Container(
                          height: heightX * 0.09,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              if(index == 4)
                              {
                                FirebaseAuth.instance.signOut().then((_){
                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const LoginScreen()), (Route<dynamic> route) => false,);
                                });
                              }
                              else{
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                listTileScreens[index]));
                              }

                            },
                            child: ListTile(
                              leading: Icon(
                                info[index]['icon'],
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                info[index]['title'],
                                style: smallTextStyle,
                              ),
                              trailing: Icon(info[index]['staticIcon']),
                              // subtitle: Text(info[index]['description']),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
