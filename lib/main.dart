import 'package:beauty_salon/UI/screens/admin-ui/add_category_provider.dart';
import 'package:beauty_salon/UI/screens/auth/login_screen/login_provider.dart';
import 'package:beauty_salon/UI/screens/auth/signup_screen/signup_provider.dart';
import 'package:beauty_salon/UI/screens/cart_screen/cart_provider.dart';
import 'package:beauty_salon/UI/screens/favourite/fav_stylists_provider.dart';
import 'package:beauty_salon/UI/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'UI/screens/bookings/booking_provider.dart';
import 'UI/screens/favourite/fav_provider.dart';
import 'UI/screens/onboarding_screen/onboarding_provider.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> OnboardingProvider()),
      ChangeNotifierProvider(create: (_)=> SignupProvider()),
      ChangeNotifierProvider(create: (_)=> LoginProvider()),
      ChangeNotifierProvider(create: (_)=> FavProvider()),
      ChangeNotifierProvider(create: (_)=> FavStylistsProvider()),
      ChangeNotifierProvider(create: (_)=> CartProvider()),
      ChangeNotifierProvider(create: (_)=> BookingProvider()),
      ChangeNotifierProvider(create: (_)=> AddCategoryProvider()),
    ],
    child: const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
    );
  }
}

