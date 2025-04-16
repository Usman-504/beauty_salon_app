import 'package:beauty_salon/view/user_view/splash_view.dart';
import 'package:beauty_salon/utils/assets.dart';
import 'package:beauty_salon/view_model/user_view_model/book_appointment_view_model.dart';
import 'package:beauty_salon/view_model/user_view_model/booking_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'view_model/user_view_model/forget_password_view_model.dart';
import 'view_model/user_view_model/login_view_model.dart';
import 'view_model/user_view_model/signup_view_model.dart';
import 'view_model/user_view_model/feedback_view_model.dart';
import 'view_model/user_view_model/profile_view_model.dart';
import 'view_model/user_view_model/update_password_view_model.dart';
import 'view_model/user_view_model/update_profile_info_view_model.dart';
import 'view_model/user_view_model/cart_view_model.dart';
import 'view_model/user_view_model/onboarding_view_model.dart';
import 'view_model/salon_owner_view_model/add_category_view_model.dart';
import 'view_model/salon_owner_view_model/add_service_view_model.dart';
import 'view_model/salon_owner_view_model/all_categories_view_model.dart';
import 'view_model/salon_owner_view_model/salon_owner_services_view_model.dart';
import 'view_model/salon_owner_view_model/update_category_view_model.dart';
import 'view_model/salon_owner_view_model/update_services_view_model.dart';
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

