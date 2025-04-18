import 'package:beauty_salon/view_model/user_view_model/onboarding_view_model.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/colors.dart';
import '../../res/components/custom_button.dart';
import 'login_view.dart';
import 'signup_view.dart';


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
                    style: smallTextStyle.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.normal, shadows: boxShadow),
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

                  }, style: mediumTextStyle, btnColor: AppColors.primaryColor,),
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
                            color: AppColors.whiteColor),
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
                        child: Text('Skip', style: mediumTextStyle.copyWith(color: AppColors.primaryColor),))),
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
                          color: onBoardingProvider.currentPage == index ? AppColors.primaryColor : Colors.grey,
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
