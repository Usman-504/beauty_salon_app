import 'package:beauty_salon/UI/components/app_dropdown.dart';
import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/components/image_container.dart';
import 'package:beauty_salon/UI/components/password_textfield.dart';
import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/UI/screens/User_ui/auth/signup_screen/signup_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/core/constants/const_text.dart';
import 'package:beauty_salon/generated/assets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../User_ui/auth/login_screen/login_screen.dart';

class AdminSignUpScreen extends StatefulWidget {
  const AdminSignUpScreen({super.key});

  @override
  State<AdminSignUpScreen> createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {

  @override
  void initState() {
    Future.microtask(() => context.read<SignupProvider>().clearFields());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final signUpProvider = Provider.of<SignupProvider>(context);
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
              imageUrl: Assets.signUpImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome! Sign up now',
                    style: primaryTextStyle.copyWith(
                      fontSize: heightX * 0.04,
                      shadows: boxShadow,
                    ),
                  ),
                  Text(
                    authDetail,
                    style: smallTextStyle.copyWith(
                        fontSize: heightX * 0.02,
                        color: kWhiteColor,
                        shadows: boxShadow),
                  ),

                ],
              ),
            ),
            // Positioned(
            //   top: heightX * 0.17,
            //   left: widthX * 0.07,
            //   child: Text(
            //     'Welcome! Sign up now',
            //     style: primaryTextStyle.copyWith(
            //       fontSize: heightX * 0.04,
            //       shadows: boxShadow,
            //     ),
            //   ),
            // ),
            // Positioned(
            //     top: heightX * 0.215,
            //     left: widthX * 0.2,
            //     child: Text(
            //       authDetail,
            //       style: smallTextStyle.copyWith(
            //           fontSize: heightX * 0.02,
            //           color: kWhiteColor,
            //           shadows: boxShadow),
            //     )),
            Positioned(
              left: widthX * 0.05,
              top: heightX * 0.365,
              child: WhiteContainer(
                height: heightX * 0.58,
                width: widthX * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: heightX * 0.02,
                    ),
                    CustomTextField(
                      hintText: 'Enter Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08,
                      controller: signUpProvider.nameController,
                      suffix: const Icon(Icons.person),
                    ),
                    CustomTextField(
                      hintText: 'Enter Email',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08,
                      controller: signUpProvider.emailController,
                      suffix: const Icon(Icons.email_outlined),
                    ),
                    CustomTextField(
                      keyBoardType: TextInputType.number,
                      hintText: 'Enter Mobile No',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08,
                      controller: signUpProvider.phoneNoController,
                      suffix: const Icon(Icons.phone),
                    ),
                    PasswordTextField(controller: signUpProvider.passwordController),
                    Padding(
                      padding:   EdgeInsets.only(left: widthX * 0.04,
                        right: widthX * 0.04,),
                      child: AppDropDown(labelText: 'Select Role', items: const ['Admin', 'Client'], onChanged: signUpProvider.onChangeRole, fillColor: Colors.white,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthX * 0.03,
                          right: widthX * 0.03,
                          top: widthX * 0.02,
                          bottom: widthX * 0.03),
                      child: CustomButton(
                        height: heightX * 0.06,
                        width: widthX * 0.8,
                        text: 'Sign Up',
                        onPress: () async{
                          try {
                            String? validation = signUpProvider.validation();
                            if(validation != null){
                              Utils().showSnackBar(context, validation );
                            }
                            else {
                              String? error = await signUpProvider.adminSignUp();
                              if (error == null) {
                                Utils().showSnackBar(context, 'Account Created Successfully');
                                Navigator.pop(context);
                              }
                              else {
                                Utils().showSnackBar(context, error,);

                              }
                            }
                          } catch (e) {
                            Utils().showSnackBar(context, 'An unexpected error occurred. Please try again.',);
                            debugPrint(e as String?) ;
                          }
                        },
                        borderRadius: heightX * 0.01, style: mediumTextStyle.copyWith(fontSize: heightX * 0.025), btnColor: kPrimaryColor,
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     const CustomDivider(),
                    //     Text(
                    //       'Or Sign Up with',
                    //       style:
                    //       smallTextStyle.copyWith(fontSize: heightX * 0.02),
                    //     ),
                    //     const CustomDivider(),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: heightX * 0.02,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // SocialContainer(
                    //     //   imageUrl: Assets.facebookIcon,
                    //     //   text: 'Facebook',
                    //     //   onPress: () {},
                    //     //   height: heightX * 0.04,
                    //     // ),
                    //     // SizedBox(
                    //     //   width: widthX * 0.03,
                    //     // ),
                    //     SocialContainer(
                    //       imageUrl: Assets.googleIcon,
                    //       text: 'Google',
                    //       onPress: () {
                    //         signUpProvider.signUpWithGoogle(context);
                    //
                    //       },
                    //       height: heightX * 0.033, width: widthX * 0.8,
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: heightX * 0.02,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Already have an account?',
                    //       style: smallTextStyle.copyWith(
                    //           fontSize: heightX * 0.02,
                    //           fontWeight: FontWeight.normal),
                    //     ),
                    //     SizedBox(
                    //       width: widthX * 0.01,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const LoginScreen()));
                    //       },
                    //       child: Text(
                    //         'Login Now',
                    //         style: smallTextStyle.copyWith(
                    //             fontSize: heightX * 0.02),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: heightX * 0.02,
                    // ),
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