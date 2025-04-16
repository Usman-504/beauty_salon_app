import 'package:beauty_salon/view_model/user_view_model/signup_provider.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:beauty_salon/utils/assets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/colors.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/custom_divider.dart';
import '../../res/components/custom_textfield.dart';
import '../../res/components/image_container.dart';
import '../../res/components/password_textfield.dart';
import '../../res/components/snackbar.dart';
import '../../res/components/social_container.dart';
import '../../res/components/white_container.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
      backgroundColor: AppColors.containerColor,
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
                    'Enter your information below',
                    style: smallTextStyle.copyWith(
                        fontSize: heightX * 0.02,
                        color: AppColors.whiteColor,
                        shadows: boxShadow),
                  ),
                  SizedBox(
                    height: heightX * 0.2,
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
              top: heightX * 0.265,
              child: WhiteContainer(
                height: heightX * 0.68,
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
                      padding: EdgeInsets.only(
                          left: widthX * 0.03,
                          right: widthX * 0.03,
                          top: widthX * 0.02,
                          bottom: widthX * 0.03),
                      child: CustomButton(
                        height: heightX * 0.06,
                        width: widthX * 0.8,
                        text: 'Sign Up',
                        loading: signUpProvider.loading,
                        onPress: () async{
                          try {
                            String? validation = signUpProvider.validation();
                            if(validation != null){
                              Utils().showSnackBar(context, validation );
                            }

                            else {
                              String? error = await signUpProvider.signUp();
                              if (error == null) {
                                Utils().showSnackBar(context, 'Account Created Successfully');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                           const  LoginScreen()));
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
                        borderRadius: heightX * 0.01, style: mediumTextStyle.copyWith(fontSize: heightX * 0.025), btnColor: AppColors.primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        const CustomDivider(),
                        Text(
                          'Or Sign Up with',
                          style:
                              smallTextStyle.copyWith(fontSize: heightX * 0.02),
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
                        //   onPress: () {},
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
                          'Already have an account?',
                          style: smallTextStyle.copyWith(
                              fontSize: heightX * 0.02,
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
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            'Login Now',
                            style: smallTextStyle.copyWith(
                                fontSize: heightX * 0.02),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightX * 0.02,
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
