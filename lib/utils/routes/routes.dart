import 'package:beauty_salon/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';



class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        // return MaterialPageRoute(builder: (_)=>const SplashView());
      case RoutesName.welcome:
        // return MaterialPageRoute(builder: (_)=>const WelcomeView());
      case RoutesName.signIn:
        // return MaterialPageRoute(builder: (_)=>const SignInView());
      case RoutesName.signUp:
        // return MaterialPageRoute(builder: (_)=>const SignUpView());


      default:
        return MaterialPageRoute(builder: (_){
          return const  Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}