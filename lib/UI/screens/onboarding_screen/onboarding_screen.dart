import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/screens/onboarding_screen/onboarding_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../User_ui/auth/login_screen/login_screen.dart';
import '../User_ui/auth/signup_screen/signup_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final onBoardingProvider = Provider.of<OnboardingProvider>(context);
    return Scaffold(
      body: PageView.builder(
          itemCount: onBoardingProvider.pageDetails.length,
          controller: onBoardingProvider.pageController,
          itemBuilder: (context, int index) {
            return Stack(
              children: [
                Container(
                  height: heightX * 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image: AssetImage(
                              onBoardingProvider.pageDetails[index]['bgImage']))),

                ),
                Positioned(
                  top: heightX * 0.65,
                  left: widthX * 0.15,
                  child: Text(
                    onBoardingProvider.pageDetails[index]['title'],
                    style: secondaryTextStyle.copyWith(shadows: boxShadow),
                  ),
                ),
                Positioned(
                  top: heightX * 0.7,
                   left: widthX * 0.08,
                  child: Text(
                    textAlign: TextAlign.center,
                    onBoardingProvider.pageDetails[index]['description'],
                    style: smallTextStyle.copyWith(color: kWhiteColor, fontWeight: FontWeight.normal, shadows: boxShadow),
                  ),
                ),
                Positioned(
                  top: heightX * 0.78,
                  left: widthX * 0.05,
                  child: CustomButton(
                    height: heightX * 0.06, width: widthX * 0.9, text: onBoardingProvider.pageDetails[index]['btnText'], borderRadius: 25, onPress: (){
                      if(index != onBoardingProvider.pageDetails.length-1) {
                        onBoardingProvider.nextPage();
                      }
                      else{ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
                      }

                  }, style: mediumTextStyle, btnColor: kPrimaryColor,),
                ),
                Positioned(
                  top:  heightX *0.85,
                  left: widthX * 0.13,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: smallTextStyle.copyWith(
                            fontSize: heightX * 0.02,
                            fontWeight: FontWeight.normal,
                            color: kWhiteColor),
                      ),
                      SizedBox(
                        width: widthX * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'Login Now',
                          style: smallTextStyle.copyWith(
                              fontSize: widthX * 0.042),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: heightX * 0.09,
                    left: widthX * 0.75,
                    child: TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
                    },
                        child: Text('Skip', style: mediumTextStyle.copyWith(color: kPrimaryColor),))),
                Positioned(
                  bottom: heightX * 0.1,
                  left: widthX * 0.5 - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingProvider.pageDetails.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: onBoardingProvider.currentPage == index ? kPrimaryColor : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
