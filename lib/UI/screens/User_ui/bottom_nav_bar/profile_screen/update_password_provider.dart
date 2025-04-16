import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../res/components/snackbar.dart';

class UpdatePasswordProvider with ChangeNotifier {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void validation(BuildContext context) {
    if (oldPasswordController.text.isEmpty) {
      return Utils().showSnackBar(context, 'Please Enter Your Old Password');
    } else if (newPasswordController.text.isEmpty) {
      return Utils().showSnackBar(context, 'Please Enter Your New Password');
    } else if (confirmPasswordController.text.isEmpty) {
      return Utils()
          .showSnackBar(context, 'Please Enter Your Confirm Password');
    } else if (oldPasswordController.text == newPasswordController.text) {
      return Utils().showSnackBar(context, 'Old & New Password Cannot Be Same');
    } else if (newPasswordController.text != confirmPasswordController.text) {
      return Utils()
          .showSnackBar(context, 'New & Confirm Password Are Not Same');
    }
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final credential = EmailAuthProvider.credential(
          email: user!.email!, password: oldPasswordController.text.trim());
      await user.reauthenticateWithCredential(credential);
      if (oldPasswordController.text != newPasswordController.text &&
          newPasswordController.text == confirmPasswordController.text) {
        await user.updatePassword(newPasswordController.text.trim()).then((value){
          Navigator.pop(context);
        });
        Utils().showSnackBar(context, 'Password Updated Successfully');

      }
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-credential') {
        Utils().showSnackBar(context, 'Old Password Is Incorrect');
      } else if (e.code == 'too-many-requests') {
        Utils().showSnackBar(context, 'Too Many Requests. Try Again Later');
      }

      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  void clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
  }

}
