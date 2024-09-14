import 'package:beauty_salon/UI/screens/User_ui/auth/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GestureDetector(
          onTap: () async{
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text('Profile'))),
    );
  }
}
