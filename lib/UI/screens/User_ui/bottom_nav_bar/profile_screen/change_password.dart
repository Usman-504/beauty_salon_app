import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/profile_screen/update_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../res/colors.dart';
import '../../../../../utils/styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<UpdatePasswordProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final updatePasswordProvider = Provider.of<UpdatePasswordProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: AppColors.whiteColor,
            )),
        centerTitle: true,
        title: Text('Change Password',
            style: secondaryTextStyle.copyWith(
                color: AppColors.whiteColor, fontSize: widthX * 0.063)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(hintText: 'Old Password', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: updatePasswordProvider.oldPasswordController,),
          CustomTextField(hintText: 'New Password', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: updatePasswordProvider.newPasswordController,),
          CustomTextField(hintText: 'Confirm New Password', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: updatePasswordProvider.confirmPasswordController,),
          CustomButton(height: heightX * 0.06, width: widthX * 0.9, text: 'Save', borderRadius: 10, onPress: (){
            updatePasswordProvider.validation(context);
            updatePasswordProvider.changePassword(context);
          }, style: mediumTextStyle, btnColor: AppColors.primaryColor,)
        ],
      ),
    );
  }
}