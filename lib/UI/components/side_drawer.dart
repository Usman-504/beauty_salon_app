
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/User_ui/auth/login_screen/login_screen.dart';
import '../screens/User_ui/bookings/booking_screen.dart';
import '../screens/User_ui/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import '../screens/User_ui/bottom_nav_bar/profile_screen/about_us_screen.dart';
import '../screens/User_ui/bottom_nav_bar/profile_screen/privacy_screen.dart';
import '../screens/User_ui/bottom_nav_bar/profile_screen/profile_provider.dart';
import '../screens/User_ui/bottom_nav_bar/services/services_list/services_list.dart';
import '../screens/User_ui/bottom_nav_bar/services/sub_services/sub_services.dart';
import '../screens/User_ui/cart_screen/cart_screen.dart';
import '../screens/admin-ui/all_categories/all_categories_provider.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var widthX = MediaQuery.of(context).size.width;
    var heightX = MediaQuery.of(context).size.height;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    return Drawer(
      backgroundColor: kContainerColor,
      // width: widthX * 0.6,
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //     image: AssetImage(Assets.mahnoorStylistImage)),
            ),
            accountName: Text(profileProvider.name, style: smallTextStyle.copyWith(color: kContainerColor),),
            accountEmail: Text(profileProvider.email!, style: smallTextStyle.copyWith(color: kContainerColor),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: profileProvider.profileUrl.isNotEmpty ?
              NetworkImage(profileProvider.profileUrl) :
              const AssetImage(Assets.dp)
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
                    },
                  ),
                  ExpansionTile(
                    iconColor: kPrimaryColor,
                  
                   childrenPadding: const EdgeInsets.only(left: 28),
                    title: Text('All Services', style: mediumTextStyle.copyWith(color: kPrimaryColor),),
                  leading: const Icon(Icons.filter_vintage_outlined),
                  
                    children: [
                      SizedBox(
                        height: heightX * 0.2,
                        child: StreamBuilder(
                          stream: allCategoriesProvider.getServices(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              print('Empty');
                            }
                            if (snapshot != null && snapshot.data != null) {
                              return  ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index){
                                    return  ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Image(image: NetworkImage(snapshot.data!.docs[index]['image_url'], ), height: 20, width: 20, color: kPrimaryColor,),
                                      title: Text(
                                        snapshot.data!.docs[index]
                                        ['category_name'],
                                        style:smallTextStyle.copyWith(color: kPrimaryColor),
                                      ),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SubServices(text:snapshot.data!.docs[index]
                                        ['category_name'], subServices: allCategoriesProvider
                                            .getSubServices(
                                            allCategoriesProvider
                                                .categoryList[
                                            index]), catId:  allCategoriesProvider
                                            .categoryList[index],)));
                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubServices(services: serviceCategories[index]['services'], text: serviceCategories[index]['title'])));
                                      },
                                    );
                                  });
                            }
                           return const CircularProgressIndicator();
                          },
                        ),
                      ),
                  
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart_rounded),
                    title: Text(
                      'Cart',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call_to_action),
                    title: Text(
                      'Booking',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(bookingDetails: {})));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outlined),
                    title: Text(
                      'About Us',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutUsScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text(
                      'Privacy',
                      style: mediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PrivacyScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
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
