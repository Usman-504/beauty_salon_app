import 'package:flutter/material.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_styles.dart';
import '../bottom_nav_screen/bottom_nav_bar.dart';

class PrivacyScreen extends StatelessWidget {
  final bool drawer;
  const PrivacyScreen({
    this.drawer = false,
    super.key});

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              !drawer ?  Navigator.pop(context):
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottomNavBar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('Privacy Policy',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: widthX * 0.063)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(heightX * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Introduction',
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
              Text(
                'At Beautilly, we value your privacy. This policy outlines how we handle your personal information when you use our app.',
                style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: widthX * 0.045),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: heightX * 0.03,
              ),
              Text(
                '2. Information We Collect',
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
              Text(
                'We Collect Name, email, phone number, profile picture, payment details, appointment history.',
                style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: widthX* 0.045),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: heightX * 0.03,
              ),
              Text(
                '3. Why We Collect Info?',
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
              Text(
                'We use your information to:\na. Provide, maintain, and improve our services.\nb. Process transactions and send confirmations.\nc. Manage your appointments and bookings.\nd. Communicate with you regarding your appointments, promotions, and updates.\ne. Personalize your experience based on your preferences.\nf. Enhance the security of our App.',
                style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: widthX * 0.045),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: heightX * 0.03,
              ),
              Text(
                '4. Data Security',
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
              Text(
                'We implement appropriate technical and organizational measures to safeguard your personal information. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.',
                style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: widthX * 0.045),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: heightX * 0.03,
              ),
              Text(
                '5. Changes to This Privacy Policy',
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
              Text(
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on the App and updating the effective date.',
                style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: widthX * 0.045),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
