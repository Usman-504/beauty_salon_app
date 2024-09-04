import 'package:beauty_salon/UI/screens/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('About Us',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: heightX * 0.03)),
      ),
      body: Padding(
        padding:  EdgeInsets.all(heightX * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About Us:', style: mediumTextStyle.copyWith(color: kPrimaryColor),),
              Text('Welcome to Beautilly, where beauty meets excellence! At our salon, we believe that beauty is more than just skin deep—it\'s an experience. With a passion for perfection and a commitment to quality, we offer a wide range of services tailored to meet your unique beauty needs.\n\nOur team of highly skilled professionals is dedicated to providing personalized care and attention to every client. Whether you\'re looking for a fresh haircut, a rejuvenating facial, or a luxurious manicure, we have you covered. We stay ahead of the latest trends and use only the best products to ensure that you leave our salon feeling confident and beautiful.\n\nAt Beautilly, we understand that your time is valuable. That\'s why we\'ve made it easier than ever to book appointments, browse our services, and stay updated with our latest offerings—all through our user-friendly app. We\'re here to make sure your salon experience is as relaxing and enjoyable as possible.\n\nThank you for choosing Beautilly. We look forward to serving you and helping you shine with confidence!', style: smallTextStyle.copyWith(fontWeight: FontWeight.normal, fontSize: heightX * 0.022), textAlign: TextAlign.justify,),
            ],
          ),
        ),
      ),
    );
  }
}
