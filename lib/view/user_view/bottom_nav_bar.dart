import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import 'booking_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'all_services.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  List<Widget> screens = [
    const HomeScreen(),
    const AllServices(),
      const BookingScreen(),
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

    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomBarInspiredOutside(
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
          
        },
        backgroundColor: AppColors.whiteColor,
        items: items,
        colorSelected: AppColors.whiteColor,
        color: AppColors.primaryColor,
        indexSelected: selectedIndex,
        animated: false,

        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(background: AppColors.primaryColor),
        titleStyle: smallTextStyle.copyWith(fontSize: widthX *0.032),

      ),
    );
  }
}
