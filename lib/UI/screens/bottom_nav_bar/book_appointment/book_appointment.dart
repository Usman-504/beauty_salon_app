import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/cart_screen/cart_screen.dart';
import 'package:beauty_salon/UI/screens/stylists/stylists_list/stylists_list.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_button.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    var selectedDate = DateTime.now();
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kButtonColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const BottomNavBar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('Book Appointment',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: heightX * 0.03)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: heightX * 0.2,
              color: kContainerColor,
              child: Column(
                children: [
                  SizedBox(
                    height: heightX * 0.025
                  ),
                  SizedBox(
                    height: heightX * 0.15,
                    child: DatePicker(
                      DateTime.now(),
                      width: heightX * 0.11,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: kButtonColor,
                      selectedTextColor: kWhiteColor,
                      onDateChange: (date){
                        selectedDate = date;
                        debugPrint(selectedDate.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightX * 0.01,
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: widthX * 0.03,
            //       right: widthX * 0.03,
            //       top: heightX * 0.01),
            //   child: Text(
            //     'Choose Stylist',
            //     style: mediumTextStyle.copyWith(color: kButtonColor),
            //   ),
            // ),
            // Padding(
            //   padding:
            //   EdgeInsets.only(left: widthX * 0.03, right: widthX * 0.03),
            //   child: SizedBox(
            //     height: heightX * 0.15,
            //     child: GridView.builder(
            //         shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //         itemCount: stylists.length,
            //         gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 1,
            //
            //             mainAxisSpacing: 5,
            //             childAspectRatio: 4 /3),
            //         itemBuilder: (context, int index) {
            //           return Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               CircleAvatar(radius: heightX * 0.05,
            //                 backgroundImage: AssetImage(stylists[index]['image']),
            //               ),
            //               Text(stylists[index]['name'], style: smallTextStyle,)
            //             ],
            //           );
            //         }),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: widthX * 0.03,
            //       right: widthX * 0.03,
            //       top: heightX * 0.01),
            //   child: Text(
            //     'Available Time Slots',
            //     style: mediumTextStyle.copyWith(color: kButtonColor),
            //   ),
            // ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(left: widthX * 0.03, right: widthX * 0.03),
            //   child: SizedBox(
            //     height: heightX * 0.06,
            //     child: GridView.builder(
            //          shrinkWrap: true,
            //        scrollDirection: Axis.horizontal,
            //         itemCount: stylists.length,
            //         gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 1,
            //             crossAxisSpacing: 5,
            //             mainAxisSpacing: 5,
            //             childAspectRatio:3/ 6),
            //         itemBuilder: (context, int index) {
            //           return Container(
            //             decoration: BoxDecoration(
            //                 color: kContainerColor,
            //                 borderRadius: BorderRadius.circular(5),
            //                 border: Border.all(width: 2, color: kButtonColor)),
            //             child: Center(
            //                 child: Text(
            //               stylists[0]['time'][index],
            //               style: smallTextStyle,
            //             )),
            //           );
            //         }),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthX * 0.03,
                  right: widthX * 0.03,
                  top: heightX * 0.03),
              child: Text('Fill Out Your Details',
                  style: mediumTextStyle.copyWith(
                      color: kButtonColor, fontSize: heightX * 0.024)),
            ),
            CustomTextField(
                hintText: 'Enter Name',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.07),
            CustomTextField(
                hintText: 'Enter Phone',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.07),
            CustomTextField(
                hintText: 'Enter Address',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.07),
            CustomTextField(
                hintText: 'Enter Message',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.07),
            Padding(
              padding:
                  EdgeInsets.only(left: widthX * 0.03, right: widthX * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    height: heightX * 0.06,
                    width: widthX * 0.44,
                    text: 'Salon',
                    onPress: () {},
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(fontSize: heightX * 0.022),
                  ),
                  SizedBox(
                    width: widthX * 0.03,
                  ),
                  CustomButton(
                    height: heightX * 0.06,
                    width: widthX * 0.44,
                    text: 'Home',
                    onPress: () {},
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(fontSize: heightX * 0.022),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightX * 0.03,
            ),
            Center(
                child: CustomButton(
              height: heightX * 0.06,
              width: widthX * 0.9,
              text: 'Proceed',
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              },
              borderRadius: heightX * 0.013,
              style: mediumTextStyle.copyWith(fontSize: heightX * 0.022),
            )),
          ],
        ),
      ),
    );
  }
}
