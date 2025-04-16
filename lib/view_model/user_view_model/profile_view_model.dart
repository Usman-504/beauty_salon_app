import 'package:beauty_salon/view/user_view/signup_view.dart';
import 'package:beauty_salon/view/user_view/privacy_view.dart';
import 'package:beauty_salon/view/salon_owner_view/salon_owner_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/components/alert_dialog.dart';
import '../../res/components/snackbar.dart';
import '../../view/salon_owner_view/admin_signup_view.dart';
import '../../view/salon_owner_view/feedback_view_view.dart';
import '../../view/user_view/about_us_view.dart';
import '../../view/user_view/login_view.dart';
import '../../view/user_view/bottom_nav_bar.dart';
import '../../view/user_view/change_password_view.dart';
import '../../view/user_view/feedback_view.dart';


class ProfileProvider with ChangeNotifier{

late String _name = '';
  String get name=> _name;

String _userName = '';
String get userName=> _userName;

String _userEmail = '';
String get userEmail=> _userEmail;

String _userPhone = '';
String get userPhone=> _userPhone;

 late String _email = '';
  String? get email=> _email;

late String _role = '';
String? get role=> _role;

late String _profileUrl = '';
String get profileUrl => _profileUrl;

final List<Map<String, dynamic>> info = [
  {
    'title': 'Change Password',
    'description': '',
    'icon': Icons.password,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'About Us',
    'description': 'Learn more about our app',
    'icon': Icons.info_outlined,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Privacy',
    'description': 'Learn more about Privacy',
    'icon': Icons.privacy_tip,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Send Feedback',
    'description': 'Send us valuable Feedback',
    'icon': Icons.message,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Delete Account',
    'description': '',
    'icon': Icons.auto_delete_outlined,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Logout',
    'description': '',
    'icon': Icons.logout,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
];
final List<Map<String, dynamic>> adminInfo = [
  {
    'title': 'Change Password',
    'description': '',
    'icon': Icons.password,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'About Us',
    'description': 'Learn more about our app',
    'icon': Icons.info_outlined,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Privacy Policy',
    'description': 'Learn more about Privacy',
    'icon': Icons.privacy_tip,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'View Feedback',
    'description': 'Send us valuable Feedback',
    'icon': Icons.message,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Create New Account',
    'description': 'Send us valuable Feedback',
    'icon': Icons.account_circle,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Delete Account',
    'description': '',
    'icon': Icons.auto_delete_outlined,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
  {
    'title': 'Logout',
    'description': '',
    'icon': Icons.logout,
    'staticIcon': Icons.arrow_forward_ios_rounded,
  },
];

List<Widget> listTileScreens = [
  const ChangePasswordScreen(),
  const AboutUsScreen(),
  const PrivacyScreen(),
  const FeedbackScreen(),

];
List<Widget> AdminlistTileScreens = [
  const ChangePasswordScreen(),
  const AboutUsScreen(),
  const PrivacyScreen(),
  const FeedbackView(),
  const AdminSignUpScreen(),
];

void navigateToScreen(BuildContext context, int index) async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? role = sp.getString('role');
  if(role == 'client'){
    if(index ==4){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return  ShowAlertDialog(message: 'Are you sure you want to delete your account?', onPress: () {  deleteUser(context,); },);
          });

    //  deleteUser(context);
    }
    else if(index == 5)
    {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return  ShowAlertDialog(message: 'Are you sure you want to logout your account?', onPress: () {
              FirebaseAuth.instance.signOut().then((_) async{
                await sp.remove('role');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()),
                  // (Route<dynamic> route) => false,
                );
              });
              GoogleSignIn().signOut().then((_){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()), );
              });
            },);
          });
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> listTileScreens[index]));
    }
  }
  if(role == 'salon owner'){
    if(index ==5){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return  ShowAlertDialog(message: 'Are you sure you want to delete your account?', onPress: () {  deleteUser(context); },);
          });
    }
    else if(index == 6)
    {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return  ShowAlertDialog(message: 'Are you sure you want to logout your account?', onPress: () {
              FirebaseAuth.instance.signOut().then((_) async{
                await sp.remove('role');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()),
                  // (Route<dynamic> route) => false,
                );
              });
              GoogleSignIn().signOut().then((_){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()), );
              });
            },);
          });

    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminlistTileScreens[index]));
    }
  }

}

  void fetchUserDetails ()async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name') ?? '';
    _email = sp.getString('email') ?? '';
    _profileUrl = sp.getString('profile_url') ?? '';
    _role = sp.getString('role') ?? '';
    notifyListeners();
  }

  void userDetails() async{
    User? user = FirebaseAuth.instance.currentUser;

   DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
   _userName = userDoc.get('name');
   _userEmail = userDoc.get('email');
   _userPhone = userDoc.get('phone_no');
    notifyListeners();
   print(userEmail);
   print(userName);
   print(userPhone);
  }

Future<void> deleteUser (BuildContext context) async{
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    String imagePath = userDoc.get('image_path');
    if(imagePath.isNotEmpty){
      await FirebaseStorage.instance.ref(imagePath).delete();
    }
    await FirebaseFirestore.instance.collection('user').doc(user.uid).delete();
    // User userToDelete = (await FirebaseAuth.instance.fetchSignInMethodsForEmail(userDoc.get('email'))).first as User;
    await user.delete();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const SignUpScreen()), (Route<dynamic> route) => false,);
    Utils().showSnackBar(context, 'Account Deleted Successfully');
}

void navigateToHomeScreen(BuildContext context) async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? role = sp.getString('role');
  if(role == 'client'){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  const BottomNavBar()));
    return;
  }
  else {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SalonOwnerBottomNavBar()));
    return;
  }
}
// void getProfileImage() async{
//   User? user = FirebaseAuth.instance.currentUser;
//   DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
//   String imageUrl = userDoc.get('image_url') ;
//   if(imageUrl.isNotEmpty) {
//     // SharedPreferences sp = await SharedPreferences.getInstance();
//     // sp.setString('profile_url', imageUrl);
//     notifyListeners();
//
//   }
//
//
// }



}