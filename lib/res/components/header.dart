import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:beauty_salon/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/user_view_model/profile_provider.dart';
import '../../view/user_view/profile_screen.dart';
import '../../res/colors.dart';
import 'filter_icon.dart';

class Header extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Header({
    required this.scaffoldKey,
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController searchController = TextEditingController();

  bool  _showSecondText = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Stack(
      children: [
        Container(
          height: heightX * 0.25,
          color: AppColors.whiteColor,
        ),
        Positioned(
          top: heightX * 0.075,
          left: widthX * 0.05,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.scaffoldKey.currentState?.openDrawer();
                },
                child: Image.asset(
                  Assets.menuIcon,
                  color: AppColors.primaryColor,
                  height: heightX * 0.04,
                ),
              ),
              SizedBox(
                width: widthX * 0.03,
              ),
              Text(
                'Hi There',
                style: mediumTextStyle.copyWith(
                    fontSize: widthX * 0.058, color: AppColors.primaryColor),
              ),
              SizedBox(
                width: widthX * 0.4,
              ),
            ],
          ),
        ),
        Positioned(
          left: widthX * 0.81,
          top: heightX * 0.062,
          child: Container(
            height: heightX * 0.07,
            width: heightX * 0.07,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 3),
                shape: BoxShape.circle),
          ),

        ),
        Positioned(
          left: widthX * 0.82,
          top: heightX * 0.067,
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              child: Container(
                height: heightX * 0.06,
                width: heightX * 0.06,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: profileProvider.profileUrl.isNotEmpty
                            ? NetworkImage(profileProvider.profileUrl)
                            : const AssetImage(Assets.dp)),
                    shape: BoxShape.circle),
              )
              // CircleAvatar(
              //   radius: heightX * 0.025,
              //   backgroundImage:
              //   profileProvider.profileUrl.isNotEmpty ?
              //   NetworkImage(profileProvider.profileUrl) :
              //   const AssetImage(Assets.dp),
              // ),
              ),
        ),
        Positioned(
          top: heightX * 0.12,
          child: Padding(
            padding:  EdgeInsets.only(left: widthX * 0.05, top: _showSecondText==false ?widthX * 0.07: widthX * 0.02),
            child: Column(
              children: [
                AnimatedTextKit(
                  totalRepeatCount: 1,
                //  repeatForever: true,
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    WavyAnimatedText(
                      textStyle: primaryTextStyle.copyWith(color: AppColors.primaryColor, fontSize: 25, fontFamily: 'Canterbury'),

                      speed: const Duration(milliseconds: 250),
                      'Welcome To Beautilly',
                    ),

                  ],
                  onFinished: () {

                      setState(() {
                        _showSecondText = true;
                        print(_showSecondText);
                      });

                  },
                ),

                if(_showSecondText)

                AnimatedTextKit(
                  repeatForever: true,
                  isRepeatingAnimation: true,

                  animatedTexts: [

                    TypewriterAnimatedText(
                      textStyle: primaryTextStyle.copyWith(color: AppColors.secondaryColor, fontSize: 25, fontFamily: 'Canterbury'),
                       cursor: '',
                      speed: const Duration(milliseconds: 50),
                      'Experience Elegance',
                    ),
                    TypewriterAnimatedText(
                      textStyle: primaryTextStyle.copyWith(color: AppColors.secondaryColor, fontSize: 25, fontFamily: 'Canterbury'),
                       cursor: '',
                      speed: const Duration(milliseconds: 50),
                      'Transform Your Look',
                    ),
                    TypewriterAnimatedText(
                      textStyle: primaryTextStyle.copyWith(color: AppColors.secondaryColor, fontSize: 25, fontFamily: 'Canterbury'),
                       cursor: '',
                      speed: const Duration(milliseconds: 50),
                      'Empower Your  Glow',
                    ),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ],
            ),
          ),
          // CustomTextField(
          //   // onChanged: (query){
          //   //   allCategoryProvider.searchService(query);
          //   // },
          //   // controller: searchController,
          //   hintText: 'Find Services By Name',
          //   maxWidth: widthX * 0.75,
          //   maxHeight: heightX * 0.065,
          //   prefix: const Icon(Icons.search),
          // ),
        ),
        const ShoppingCart(),
      ],
    );
  }
}
