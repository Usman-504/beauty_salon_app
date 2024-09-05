import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import '../../bookings/booking_screen.dart';
import '../home/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../services/all_services/all_services.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  List<Widget> screens = [
    const HomeScreen(),
    const AllServices(),
      BookingScreen(bookingDetails:  {},),
     ProfileScreen(),
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
    var widthX = MediaQuery.of(context).size.width;
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
        color: kPrimaryColor,
        indexSelected: selectedIndex,
        animated: false,

        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(background: kPrimaryColor),
        titleStyle: smallTextStyle.copyWith(fontSize: widthX *0.032),

      ),
    );
  }
}
