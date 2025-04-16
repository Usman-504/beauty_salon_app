import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/components/image_container.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:beauty_salon/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../res/colors.dart';
import 'forget_password_provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  @override
  void initState() {
    Future.microtask(() => context.read<ForgetPasswordProvider>().clearFields());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final forgetPasswordProvider = Provider.of<ForgetPasswordProvider>(context);
    print('Rebuild');
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: heightX * 1,
            ),
            ImageContainer(
              height: heightX * 0.8,
              imageUrl: Assets.forgetPassword,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: heightX * 0.3,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: heightX * 0.07),
                    child: Text(
                      'Forgot Password',
                      style: primaryTextStyle.copyWith(
                          fontSize: widthX * 0.085, shadows: boxShadow),
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Please type your email below and we will send you a link',
                    style: smallTextStyle.copyWith(
                        fontSize: widthX * 0.033,
                        shadows: boxShadow,
                        color: AppColors.whiteColor),
                  )
                ],
              ),
            ),
            // Positioned(
            //   top: heightX * 0.3,
            //   left: widthX * 0.13,
            //   child: Text(
            //     'Let\'s get you Login!',
            //     style: primaryTextStyle.copyWith(
            //         fontSize: widthX * 0.085, shadows: boxShadow),
            //   ),
            // ),
            // Positioned(
            //   top: heightX * 0.35,
            //   left: widthX * 0.2,
            //   child: Text(
            //     authDetail,
            //     style: smallTextStyle.copyWith(
            //         fontSize: widthX * 0.043,
            //         shadows: boxShadow,
            //         color: kWhiteColor),
            //   ),
            // ),
            Positioned(
              left: widthX * 0.05,
              top: heightX * 0.65,
              child: WhiteContainer(
                height: heightX * 0.25,
                width: widthX * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: heightX * 0.02,
                    ),
                    CustomTextField(
                      suffix: const Icon(Icons.email_outlined),
                      controller: forgetPasswordProvider.emailController,
                      hintText: 'Enter Email',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthX * 0.04,
                          right: widthX * 0.04,
                          top: widthX * 0.02,
                          bottom: widthX * 0.03),
                      child: CustomButton(
                        height: heightX * 0.07,
                        width: widthX * 0.9,
                        text: 'Reset Password',
                        onPress: (){
                          forgetPasswordProvider.resetPassword(context);
                        },
                        borderRadius: heightX * 0.01,
                        style:
                        mediumTextStyle.copyWith(fontSize: widthX * 0.05), btnColor: AppColors.primaryColor,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}