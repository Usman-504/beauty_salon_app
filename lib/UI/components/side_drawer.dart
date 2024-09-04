import 'package:beauty_salon/UI/screens/bookings/booking_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/home/home_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/profile_screen/about_us_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/profile_screen/privacy_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/services_list/services_list.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/sub_services/sub_services.dart';
import 'package:beauty_salon/UI/screens/cart_screen/cart_screen.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth/login_screen/login_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var widthX = MediaQuery.of(context).size.width;
    var heightX = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: kContainerColor,
      // width: widthX * 0.6,
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //     image: AssetImage(Assets.mahnoorStylistImage)),
            ),
            accountName: Text('Mahnoor'),
            accountEmail: Text('Abc123@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                Assets.mahnoorStylistImage,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                    },
                  ),
                  ExpansionTile(
                    iconColor: kPrimaryColor,
                  
                   childrenPadding: EdgeInsets.only(left: 28),
                    title: Text('All Services', style: mediumTextStyle.copyWith(color: kPrimaryColor),),
                  leading: Icon(Icons.filter_vintage_outlined),
                  
                    children: [
                      SizedBox(
                        height: heightX * 0.2,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                           // physics: NeverScrollableScrollPhysics(),
                            itemCount: serviceCategories.length,
                            itemBuilder: (context, index){
                              return  ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image(image: AssetImage(serviceCategories[index]['image'], ), height: 20, width: 20, color: kPrimaryColor,),
                                title: Text(
                                  serviceCategories[index]['title'],
                                  style:smallTextStyle.copyWith(color: kPrimaryColor),
                                ),
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubServices(services: serviceCategories[index]['services'], text: serviceCategories[index]['title'])));
                                },
                              );
                            }),
                      ),
                  
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart_rounded),
                    title: Text(
                      'Cart',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.call_to_action),
                    title: Text(
                      'Booking',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(bookingDetails: {})));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outlined),
                    title: Text(
                      'About Us',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text(
                      'Privacy',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PrivacyScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      FirebaseAuth.instance.signOut().then((_){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const LoginScreen()), (Route<dynamic> route) => false,);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
