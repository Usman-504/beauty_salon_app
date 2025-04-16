import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:beauty_salon/view/user_view/booking_screen_view.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../res/colors.dart';
import 'all_categories_view.dart';
import 'salon_owner_profile_view.dart';
import 'salon_owner_services_view.dart';

class SalonOwnerBottomNavBar extends StatefulWidget {
  const SalonOwnerBottomNavBar({super.key});

  @override
  State<SalonOwnerBottomNavBar> createState() => _SalonOwnerBottomNavBarState();
}

class _SalonOwnerBottomNavBarState extends State<SalonOwnerBottomNavBar> {

  List<Widget> screens = [
    SalonOwnerServicesScreen(),
     AllCategoriesScreen(),
    const BookingScreen(),
  //  AdminBookingsScreen(),
    const SalonOwnerProfileScreen(),
  ];
  List<TabItem> items = [

    const TabItem(icon: Icons.home, title: 'Services'),
    const TabItem(icon: Icons.filter_vintage_outlined, title: 'Categories'),
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
        backgroundColor: AppColors.whiteColor,
        items: items,
        colorSelected: AppColors.whiteColor,
        color: AppColors.primaryColor,
        indexSelected: selectedIndex,
        animated: false,

        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(background: AppColors.primaryColor),
        titleStyle: smallTextStyle.copyWith(fontSize: heightX *0.015),

      ),
    );
  }
}