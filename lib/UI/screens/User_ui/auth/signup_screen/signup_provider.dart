import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/UI/screens/User_ui/auth/auth_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validation() {
    if (nameController.text.isEmpty) {
      return 'Please Enter Your Name';
    } else if (emailController.text.isEmpty) {
      return 'Please Enter Your Email';
    } else if (phoneNoController.text.isEmpty) {
      return 'Please Enter Your Phone No';
    } else if (passwordController.text.isEmpty) {
      return 'Please Enter Your Password';
    }
    return null;
  }

  Future<String?> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // String userRole;
      // if(emailController.text.trim().toLowerCase() == 'usmankhan14307@gmail.com'){}
      // else{}
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': nameController.text.trim(),
        'phone_no': phoneNoController.text.trim(),
        'email': FirebaseAuth.instance.currentUser!.email,
        'role': 'client',
        'user_id': FirebaseAuth.instance.currentUser!.uid,
      });
      notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The Email Format is Invalid.';
      } else if (e.code == 'email-already-in-use') {
        return 'This Email Is Already Registered.';
      } else if (e.code == 'weak-password') {
        return 'Password Must Be At Least 6 Characters';
      } else {
        return 'An error occurred';
      }
    }
  }

  Future<User?> signUpWithGoogle(BuildContext context) async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
          'role': 'client',
          'email': user.email,
          'name': user.displayName,
          'user_id' : user.uid,
        }).then((value) async{
          //       DocumentSnapshot userDoc = await FirebaseFirestore.instance
          //           .collection('user')
          //           .doc(user.uid)
          //           .get();
          // String role = userDoc.get('role');
          //       String name = userDoc.get('name');
          //       String email = userDoc.get('email');
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('role', 'client');
                sp.setString('name', user.displayName!);
                sp.setString('email', user.email!);
                print(sp.getString('role'));
        });
       AuthCheck().checkUserRoleAndNavigate(context);
       Utils().showSnackBar(context, 'Account Login Successfully');
        return user;
      }
    } on FirebaseException catch(e){
      print(e.code);
    }
        catch (e){
      print(e);
        }
    return null;
  }

  // void userRole() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(user!.uid)
  //       .get();
  //
  //   String role = userDoc.get('role');
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('role', role);
  //   print(sp.get('User Role saved as $role'));
  //   notifyListeners();
  // }
}
