import 'package:beauty_salon/utils/styles.dart';
import 'package:beauty_salon/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../view/user_view/about_us_view.dart';
import '../../view/user_view/login_view.dart';
import '../../view/user_view/booking_screen_view.dart';
import '../../view/user_view/bottom_nav_bar.dart';
import '../../view/user_view/privacy_view.dart';
import '../../view_model/user_view_model/profile_view_model.dart';
import '../../view/user_view/sub_services_view.dart';
import '../../view/user_view/cart_view.dart';
import '../../view_model/salon_owner_view_model/all_categories_view_model.dart';
import '../../res/colors.dart';
import 'alert_dialog.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    var heightX = MediaQuery.of(context).size.height;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    return Drawer(
      backgroundColor: AppColors.containerColor,
      // width: widthX * 0.6,
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //     image: AssetImage(Assets.mahnoorStylistImage)),
            ),
            accountName: Text(profileProvider.name, style: smallTextStyle.copyWith(color: AppColors.containerColor),),
            accountEmail: Text(profileProvider.email!, style: smallTextStyle.copyWith(color: AppColors.containerColor),),
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
                      style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
                    },
                  ),
                  ExpansionTile(
                    iconColor: AppColors.primaryColor,
                  
                   childrenPadding: const EdgeInsets.only(left: 28),
                    title: Text('All Services', style: mediumTextStyle.copyWith(color: AppColors.primaryColor),),
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
                                      leading: Image(image: NetworkImage(snapshot.data!.docs[index]['image_url'], ), height: 20, width: 20, color: AppColors.primaryColor,),
                                      title: Text(
                                        snapshot.data!.docs[index]
                                        ['category_name'],
                                        style:smallTextStyle.copyWith(color: AppColors.primaryColor),
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
                      style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call_to_action),
                    title: Text(
                      'Booking',
                      style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outlined),
                    title: Text(
                      'About Us',
                      style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsScreen(drawer: true,)));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text(
                      'Privacy',
                      style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyScreen(drawer: true,)));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return  ShowAlertDialog(message: 'Are you sure you want to logout your account?', onPress: () {
                              FirebaseAuth.instance.signOut().then((_){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()),
                                  // (Route<dynamic> route) => false,
                                );
                              });
                              GoogleSignIn().signOut().then((_){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()), );
                              });
                            },);
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
