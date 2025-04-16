import 'package:beauty_salon/UI/screens/User_ui/auth/auth_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../res/components/snackbar.dart';

class SignupProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _selectedRole = '';
  String get selectedRole => _selectedRole;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

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
      setLoading(true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': nameController.text.trim(),
        'phone_no': phoneNoController.text.trim(),
        'email': FirebaseAuth.instance.currentUser!.email,
        'role': 'client',
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'image_url' : '',
        'image_path' : '',
      });
      setLoading(false);
      // notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      setLoading(false);
      if (e.code == 'invalid-email') {
        return 'The Email Format is Invalid.';
      } else if (e.code == 'email-already-in-use') {
        return 'This Email Is Already Registered.';
      } else if (e.code == 'weak-password') {
        return 'Password Must Be At Least 6 Characters';
      }else if (e.code == 'network-request-failed') {
        return 'Check Your Internet Connection.';
      }
      else {
        return 'An error occurred';
      }

    }
  }
  Future<String?> adminSignUp() async {
    try {
      setLoading(true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': nameController.text.trim(),
        'phone_no': phoneNoController.text.trim(),
        'email': FirebaseAuth.instance.currentUser!.email,
        'role': _selectedRole.toLowerCase(),
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'image_url' : '',
        'image_path' : '',
      });
      setLoading(false);
      // notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      setLoading(false);
      if (e.code == 'invalid-email') {
        return 'The Email Format is Invalid.';
      } else if (e.code == 'email-already-in-use') {
        return 'This Email Is Already Registered.';
      } else if (e.code == 'weak-password') {
        return 'Password Must Be At Least 6 Characters';
      }else if (e.code == 'network-request-failed') {
        return 'Check Your Internet Connection.';
      }
      else {
        return 'An error occurred';
      }
    }
  }

  Future<User?> signUpWithGoogle(BuildContext context) async {
    try {
      setLoading(true);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      print('Access Token: ${googleAuth.accessToken}');
      print('Id Token: ${googleAuth.idToken}');
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(user.uid);

        DocumentSnapshot docSnapshot = await userDoc.get();
        if (docSnapshot.exists) {
          await userDoc.update({
            'name': user.displayName,
          });
        }
        else {
          await userDoc.set({
            'name': user.displayName,
            'phone_no': '',
            'email': user.email,
            'role': 'client',
            'user_id': user.uid,
            'image_url': '',
            'image_path': '',
          });
        }
        SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('role', 'client');
          sp.setString('name', user.displayName!);
          sp.setString('email', user.email!);
          print(sp.getString('role'));
        AuthCheck().checkUserRoleAndNavigate(context);
        Utils().showSnackBar(context, 'Account Login Successfully');
        setLoading(false);
        return user;
      }
    } on FirebaseException catch (e) {
      setLoading(false);
      print(e.code);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signUpWithFacebook(BuildContext context) async {
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
          'role': 'client',
          'email': user.email ?? '',
          'name': user.displayName ?? '',
          'user_id': user.uid,
        }).then((value) async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('role', 'client');
          sp.setString('name', user.displayName! ?? 'null');
          sp.setString('email', user.email! ?? 'null');
          print(sp.getString('role'));
        });
        AuthCheck().checkUserRoleAndNavigate(context);
        Utils().showSnackBar(context, 'Account Login Successfully');
        return user;
      }
    } on FirebaseException catch (e) {
      print(e.code);
    }
    catch(e){
      print(e);
    }
    return null;

  }

  void onChangeRole(value){
    _selectedRole = value;
    notifyListeners();
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneNoController.clear();
    passwordController.clear();
    notifyListeners();
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
