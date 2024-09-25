import 'package:beauty_salon/UI/screens/admin-ui/add_category/add_category_provider.dart';
import 'package:beauty_salon/UI/screens/admin-ui/all_categories/all_categories_provider.dart';
import 'package:beauty_salon/UI/screens/admin-ui/update_category/update_category_provider.dart';
import 'package:beauty_salon/UI/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'UI/screens/User_ui/auth/login_screen/login_provider.dart';
import 'UI/screens/User_ui/auth/signup_screen/signup_provider.dart';
import 'UI/screens/User_ui/bookings/booking_provider.dart';
import 'UI/screens/User_ui/bottom_nav_bar/book_appointment/book_appointment_provider.dart';
import 'UI/screens/User_ui/bottom_nav_bar/profile_screen/feedback_provider.dart';
import 'UI/screens/User_ui/bottom_nav_bar/profile_screen/profile_provider.dart';
import 'UI/screens/User_ui/bottom_nav_bar/profile_screen/update_password_provider.dart';
import 'UI/screens/User_ui/bottom_nav_bar/profile_screen/update_profile_info_provider.dart';
import 'UI/screens/User_ui/cart_screen/cart_provider.dart';
import 'UI/screens/User_ui/favourite/fav_provider.dart';
import 'UI/screens/User_ui/favourite/fav_stylists_provider.dart';
import 'UI/screens/admin-ui/add_service/add_service_provider.dart';
import 'UI/screens/admin-ui/all_services/admin_services_provider.dart';
import 'UI/screens/admin-ui/update_services/update_services_provider.dart';
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
      ChangeNotifierProvider(create: (_)=> AllCategoriesProvider()),
      ChangeNotifierProvider(create: (_)=> AddCategoryProvider()),
      ChangeNotifierProvider(create: (_)=> UpdateCategoryProvider()),
      ChangeNotifierProvider(create: (_)=> AdminServicesProvider()),
      ChangeNotifierProvider(create: (_)=> AddServiceProvider()),
      ChangeNotifierProvider(create: (_)=> UpdateServicesProvider()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_)=> FeedbackProvider()),
      ChangeNotifierProvider(create: (_)=> UpdatePasswordProvider()),
      ChangeNotifierProvider(create: (_)=> UpdateProfileInfoProvider()),
      ChangeNotifierProvider(create: (_)=> BookAppointmentProvider()),
    ],
    child: const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
    );
  }
}

