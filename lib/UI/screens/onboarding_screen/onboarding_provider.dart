import 'package:flutter/material.dart';

import '../../../utils/assets.dart';

class OnboardingProvider with ChangeNotifier{

  List<Map<String, dynamic>> pageDetails = [
    {
      'bgImage' : Assets.onBoarding1,
      'title' : 'Welcome to Beautilly',
      'btnText' : 'Next',
      'description' : 'Discover beauty at your fingertips with\npersonalized services tailored to your style.',

    },
    {
      'bgImage' : Assets.onBoarding2,
      'title' : 'Meet Our Specialists',
      'btnText' : 'Next',
      'description' : 'There are many best stylists from all the\nbest salons ever',

    },
    {
      'bgImage' : Assets.onBoarding3,
      'title' : 'Find The Best Service',
      'btnText' : 'Get Started',
      'description' : 'There are various services from the best\nsalons that have become our partners.',

    },

  ];
  final pageController = PageController();
   int _currentPage = 0;
  int get currentPage => _currentPage;


  void onChange (int page){
    _currentPage = page;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < pageDetails.length - 1) {
      _currentPage++;
      pageController.nextPage(
          duration: Duration(milliseconds: 1), curve: Curves.ease);
      notifyListeners();
    }
  }
}
