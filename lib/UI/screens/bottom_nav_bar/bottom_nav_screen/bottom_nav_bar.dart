import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/booking_screen/booking_screen.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';

import '../../stylists/all_stylists.dart';
import '../home/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../services/service_categories.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  List<Widget> screens = [
    const HomeScreen(),
    const ServiceCategories(),
      BookingScreen(),
    const ProfileScreen(),
  ];
  List<TabItem> items = [

    const TabItem(icon: Icons.home, title: 'Home'),
    const TabItem(icon: Icons.filter_vintage_outlined, title: 'Services'),
    const TabItem(icon: Icons.call_to_action, title: 'Bookings'),
    const TabItem(icon: Icons.account_circle, title:'Profile'),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomBarInspiredOutside(
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
          
        },
        backgroundColor: kWhiteColor,
        items: items,
        colorSelected: kWhiteColor,
        color: kButtonColor,
        indexSelected: selectedIndex,
        animated: false,

        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(background: kButtonColor),
        titleStyle: smallTextStyle.copyWith(fontSize: heightX *0.015),

      ),
    );
  }
}
