import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class OnboardingProvider with ChangeNotifier{

  List<Map<String, dynamic>> pageDetails = [
    {
      'bgImage' : Assets.onBoarding1,
      'title' : 'Welcome to Beautilly',
      'btnText' : 'Next',
      'description' : 'Discover beauty at your fingertips with personalized services tailored to your style.',

    },
    {
      'bgImage' : Assets.onBoarding2,
      'title' : 'Meet Our Specialists',
      'btnText' : 'Next',
      'description' : 'There are many best stylists from all the best salons ever',

    },
    {
      'bgImage' : Assets.onBoarding3,
      'title' : 'Find The Best Service',
      'btnText' : 'Get Started',
      'description' : 'There are various services from the best salons that have become our partners.',

    },

  ];
  final pageController = PageController();
}
