import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/profile_screen/privacy_screen.dart';
import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/profile_screen/profile_provider.dart';
import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/profile_screen/update_profile_info_provider.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../generated/assets.dart';
import '../../auth/login_screen/login_screen.dart';
import '../bottom_nav_screen/bottom_nav_bar.dart';
import 'about_us_screen.dart';
import 'change_password.dart';
import 'edit_profile_screen.dart';
import 'feedback_screen.dart';

class ProfileScreen extends StatefulWidget {
 const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      'title': 'Delete Account',
      'description': '',
      'icon': Icons.auto_delete_outlined,
      'staticIcon': Icons.arrow_forward_ios_rounded,
    },
    {
      'title': 'Logout',
      'description': '',
      'icon': Icons.logout,
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
  void initState(){
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).fetchUserDetails();
    Provider.of<ProfileProvider>(context, listen: false).userDetails();
   // Provider.of<ProfileProvider>(context, listen: false).getProfileImage();
    Future.microtask(() => context.read<UpdateProfileInfoProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final profileProvider = Provider.of<ProfileProvider>(context);
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
                  color: kWhiteColor, fontSize: widthX * 0.063)),
        ),
        body: Padding(
          padding: EdgeInsets.all(widthX * 0.03),
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, snapshot) {
                  return Stack(
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
                          decoration:  BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: profileProvider.profileUrl.isNotEmpty ?
                                      NetworkImage(profileProvider.profileUrl) :
                              const AssetImage(Assets.dp)
                              ),
                              shape: BoxShape.circle),
                        ),
                      ),
                      Positioned(
                          top: heightX * 0.04,
                          left: widthX * 0.32,
                          child: Text(
                            profileProvider.name,
                            style: mediumTextStyle.copyWith(color: kPrimaryColor),
                          )),
                      Positioned(
                        top: heightX * 0.075,
                        left: widthX * 0.32,
                        child: Text(
                          profileProvider.email!,
                          style: smallTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                      Positioned(
                          top: heightX * 0.04,
                          left: widthX * 0.83,
                          child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditProfileScreen(name: profileProvider.userName, email: profileProvider.userEmail, phoneNo: profileProvider.userPhone, imageUrl: profileProvider.profileUrl, docId: FirebaseAuth.instance.currentUser!.uid,)));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: kPrimaryColor,
                              ))),
                    ],
                  );
                },

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
                              if(index ==4){
                                profileProvider.deleteUser(context);
                              }
                              else if(index == 5)
                              {
                                FirebaseAuth.instance.signOut().then((_){
                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const LoginScreen()), (Route<dynamic> route) => false,);
                                });
                                GoogleSignIn().signOut().then((_){
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
