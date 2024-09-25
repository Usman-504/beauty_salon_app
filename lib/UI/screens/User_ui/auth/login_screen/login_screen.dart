import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_divider.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/components/image_container.dart';
import 'package:beauty_salon/UI/components/password_textfield.dart';
import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/UI/components/social_container.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/UI/screens/User_ui/auth/signup_screen/signup_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/core/constants/const_text.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_check.dart';
import '../signup_screen/signup_screen.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

@override
  void initState() {
  Future.microtask(() => context.read<LoginProvider>().clearFields());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
final loginProvider = Provider.of<LoginProvider>(context);
final signUpProvider = Provider.of<SignupProvider>(context);
print('Rebuild');
    return Scaffold(
      backgroundColor: kContainerColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: heightX * 1,
            ),
            ImageContainer(
              height: heightX * 0.6,
              imageUrl: Assets.loginImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: heightX * 0.07),
                    child: Text(
                      'Let\'s get you Login!',
                      style: primaryTextStyle.copyWith(
                          fontSize: widthX * 0.085, shadows: boxShadow),
                    ),
                  ),
                  Text(
                    authDetail,
                    style: smallTextStyle.copyWith(
                        fontSize: widthX * 0.043,
                        shadows: boxShadow,
                        color: kWhiteColor),
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
              top: heightX * 0.4,
              child: WhiteContainer(
                height: heightX * 0.55,
                width: widthX * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: heightX * 0.02,
                    ),
                    CustomTextField(
                      suffix: const Icon(Icons.email_outlined),
                      controller: loginProvider.emailController,
                      hintText: 'Enter Email',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08,
                    ),
                   PasswordTextField(
                     controller: loginProvider.passwordController,
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: widthX * 0.05),
                          child: Text(
                            'Forgot Password?',
                            style:
                                smallTextStyle.copyWith(fontSize: widthX * 0.042),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthX * 0.04,
                          right: widthX * 0.04,
                          top: widthX * 0.06,
                          bottom: widthX * 0.03),
                      child: CustomButton(
                        height: heightX * 0.06,
                        width: widthX * 0.8,
                        text: 'Login',
                        onPress: () async{
                          try {
                            String? validation = loginProvider.validation();
                            if (validation != null){
                              Utils().showSnackBar(context, validation);
                            }
                            else {
                              String? error = await loginProvider.login();
                              if(error == null){
                                Utils().showSnackBar(context, 'Account Login Successfully');
                                AuthCheck().checkUserRoleAndNavigate(context);
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //            const BottomNavBar()));
                              }
                              else {
                                Utils().showSnackBar(context, error);
                              }
                            }
                          }
                          catch (e){
                            Utils().showSnackBar(context,
                                'An unexpected error occurred. Please try again.');
                            debugPrint(e.toString()) ;
                          }

                        },
                        borderRadius: heightX * 0.01,
                        style:
                            mediumTextStyle.copyWith(fontSize: widthX * 0.05), btnColor: kPrimaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        const CustomDivider(),
                        Text(
                          'Or login with',
                          style: smallTextStyle.copyWith(
                            fontSize: heightX * 0.02,
                          ),
                        ),
                        const CustomDivider(),
                      ],
                    ),
                    SizedBox(
                      height: heightX * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SocialContainer(
                        //   imageUrl: Assets.facebookIcon,
                        //   text: 'Facebook',
                        //   onPress: () {
                        //     signUpProvider.signUpWithFacebook(context);
                        //   },
                        //   height: heightX * 0.04,
                        // ),
                        // SizedBox(
                        //   width: widthX * 0.03,
                        // ),
                        SocialContainer(
                          imageUrl: Assets.googleIcon,
                          text: 'Google',
                          onPress: () {
                           signUpProvider.signUpWithGoogle(context);
                          },
                          height: heightX * 0.033, width: widthX * 0.8,
                        )
                      ],
                    ),
                    SizedBox(
                      height: heightX * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: smallTextStyle.copyWith(
                              fontSize: widthX * 0.042,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: widthX * 0.01,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              'Register Now',
                              style: smallTextStyle.copyWith(
                                  fontSize: widthX * 0.042),
                            )),
                      ],
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
