import 'package:beauty_salon/UI/screens/auth/signup_screen/signup_screen.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/screens/bottom_nav_bar/services/fav_provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> FavProvider()),
      ChangeNotifierProvider(create: (_)=> CartProvider()),
    ],
    child: const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    ),
    );
  }
}

