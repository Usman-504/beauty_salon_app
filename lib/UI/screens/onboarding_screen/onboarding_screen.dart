import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/screens/onboarding_screen/onboarding_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/login_screen/login_screen.dart';

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
            return Container(
              height: heightX * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          onBoardingProvider.pageDetails[index]['bgImage']))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    onBoardingProvider.pageDetails[index]['title'],
                    style: secondaryTextStyle.copyWith(shadows: boxShadow),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: widthX * 0.06, right:  widthX * 0.06),
                    child: Text(
                      textAlign: TextAlign.center,
                      onBoardingProvider.pageDetails[index]['description'],
                      style: smallTextStyle.copyWith(color: kWhiteColor, fontWeight: FontWeight.normal, shadows: boxShadow),
                    ),
                  ),
                  CustomButton(
                      height: heightX * 0.06, width: widthX * 0.9, text: onBoardingProvider.pageDetails[index]['btnText'], borderRadius: 25, onPress: (){}, style: mediumTextStyle),
                  Row(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'Login Now',
                          style: smallTextStyle.copyWith(
                              fontSize: heightX * 0.02),
                        ),
                      ),
                    ],
                  ),
                  TextButton(onPressed: (){}, child: Text('Skip', style: mediumTextStyle.copyWith(color: kWhiteColor, shadows: boxShadow),)),

                ],
              ),
            );
          }),
    );
  }
}
