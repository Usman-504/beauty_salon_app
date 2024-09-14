import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/login_screen/login_screen.dart';

class UpdateProfileInfoProvider with ChangeNotifier {


  void updateUserDetails(String name, String email, String phoneNo,
      String password, BuildContext context) async {

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (password.isEmpty) {
        Utils().showSnackBar(context, 'Password Cannot Be Empty');
        return;
      }

      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      String userName = userDoc.get('name');
      String userPhone = userDoc.get('phone_no');

      if (email != user.email) {
        await user.verifyBeforeUpdateEmail(email);
        await user.sendEmailVerification();

        await FirebaseAuth.instance.signOut();
        Utils().showSnackBar(context, 'Verify Your New Email & Login Again');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
        return;
      }

      if (name != userName || phoneNo != userPhone) {
        await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
          'name': name,
          'phone_no': phoneNo,
          'email': email,
        });

        if (name != userName) {
          Utils().showSnackBar(context, 'Profile Name Updated. Please Login Again');
        } else if (phoneNo != userPhone) {
          Utils().showSnackBar(context, 'Phone Number Updated. Please Login Again');
        }

        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
        return;
      }

      Navigator.pop(context);
      Utils().showSnackBar(context, 'Profile Updated');

    } on FirebaseException catch (e) {
      if (e.code == 'invalid-credential') {
        Utils().showSnackBar(context, 'Your Password Is Incorrect');
      } else if (e.code == 'too-many-requests') {
        Utils().showSnackBar(context, 'Too Many Requests. Try Again Later');
      }
    } catch (e) {
      print(e);
    }
  }


}
