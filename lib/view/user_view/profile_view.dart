
import 'package:beauty_salon/view_model/user_view_model/profile_view_model.dart';
import 'package:beauty_salon/view_model/user_view_model/update_profile_info_view_model.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../utils/assets.dart';

import 'edit_profile_view.dart';


class ProfileScreen extends StatefulWidget {
 const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState(){
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).fetchUserDetails();
    Provider.of<ProfileProvider>(context, listen: false).userDetails();
    Future.microtask(() => context.read<UpdateProfileInfoProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: GestureDetector(
              onTap: () {
                profileProvider.navigateToHomeScreen(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: heightX * 0.04,
                color: AppColors.whiteColor,
              )),
          centerTitle: true,
          title: Text('Profile',
              style: secondaryTextStyle.copyWith(
                  color: AppColors.whiteColor, fontSize: widthX * 0.063)),
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
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Positioned(
                        top: heightX * 0.01,
                        left: widthX * 0.02,
                        child: Container(
                          height: heightX * 0.13,
                          width: heightX * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor, width: 3),
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
                            style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
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
                        top: heightX * 0.1,
                        left: widthX * 0.32,
                        child: Text(
                          'Role: ${profileProvider.role != null && profileProvider.role!.isNotEmpty
                              ? profileProvider.role!.split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '').join(' ')
                              : 'Loading...'}',
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
                                color: AppColors.primaryColor,
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
                    itemCount: profileProvider.info.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: heightX * 0.02,
                        ),
                        child: Container(
                          height: heightX * 0.09,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              profileProvider.navigateToScreen(context, index);

                            },
                            child: ListTile(
                              leading: Icon(
                                profileProvider.info[index]['icon'],
                                color: AppColors.primaryColor,
                              ),
                              title: Text(
                                profileProvider.info[index]['title'],
                                style: smallTextStyle,
                              ),
                              trailing: Icon(profileProvider.info[index]['staticIcon']),
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
