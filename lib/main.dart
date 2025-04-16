import 'package:beauty_salon/view/user_view/splash_screen.dart';
import 'package:beauty_salon/utils/assets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'view_model/user_view_model/forget_password_provider.dart';
import 'view_model/user_view_model/login_provider.dart';
import 'view_model/user_view_model/signup_provider.dart';
import 'view_model/user_view_model/booking_provider.dart';
import 'view_model/user_view_model/book_appointment_provider.dart';
import 'view_model/user_view_model/feedback_provider.dart';
import 'view_model/user_view_model/profile_provider.dart';
import 'view_model/user_view_model/update_password_provider.dart';
import 'view_model/user_view_model/update_profile_info_provider.dart';
import 'view_model/user_view_model/cart_provider.dart';
import 'view_model/user_view_model/onboarding_provider.dart';
import 'view_model/salon_owner_view_model/add_category_provider.dart';
import 'view_model/salon_owner_view_model/add_service_provider.dart';
import 'view_model/salon_owner_view_model/all_categories_provider.dart';
import 'view_model/salon_owner_view_model/salon_owner_services_provider.dart';
import 'view_model/salon_owner_view_model/update_category_provider.dart';
import 'view_model/salon_owner_view_model/update_services_provider.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = Assets.stripePublishableKey;
  await Stripe.instance.applySettings();
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
      ChangeNotifierProvider(create: (_)=> CartProvider()),
      ChangeNotifierProvider(create: (_)=> BookingProvider()),
      ChangeNotifierProvider(create: (_)=> AllCategoriesProvider()),
      ChangeNotifierProvider(create: (_)=> AddCategoryProvider()),
      ChangeNotifierProvider(create: (_)=> UpdateCategoryProvider()),
      ChangeNotifierProvider(create: (_)=> SalonOwnerServicesProvider()),
      ChangeNotifierProvider(create: (_)=> AddServiceProvider()),
      ChangeNotifierProvider(create: (_)=> UpdateServicesProvider()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_)=> FeedbackProvider()),
      ChangeNotifierProvider(create: (_)=> UpdatePasswordProvider()),
      ChangeNotifierProvider(create: (_)=> UpdateProfileInfoProvider()),
      ChangeNotifierProvider(create: (_)=> BookAppointmentProvider()),
      ChangeNotifierProvider(create: (_)=> ForgetPasswordProvider()),
    ],
    child: const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
    );
  }
}

