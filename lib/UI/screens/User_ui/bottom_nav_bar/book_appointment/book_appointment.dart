import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/components/snackbar.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../components/custom_button.dart';
import '../../checkout/checkout_screen.dart';
import '../../stylists/stylists_list/stylists_list.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({required this.serviceIndex, super.key});

  final Map serviceIndex;

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var selectedDate = DateTime.now();
  String? selectedTimeSlot;
  String? serviceType;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
print(widget.serviceIndex);
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('Book Appointment',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: widthX * 0.062)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: heightX * 0.2,
              color: kWhiteColor,
              child: Column(
                children: [
                  SizedBox(height: heightX * 0.025),
                  SizedBox(
                    height: heightX * 0.15,
                    child: DatePicker(
                      DateTime.now(),
                      width: heightX * 0.11,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: kPrimaryColor,
                      selectedTextColor: kWhiteColor,
                      onDateChange: (date) {
                        setState(() {
                          selectedDate = date;
                        });
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
            Padding(
              padding: EdgeInsets.only(
                  left: widthX * 0.03,
                  right: widthX * 0.03,
                  top: heightX * 0.01),
              child: Text(
                'Available Time Slots',
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: widthX * 0.03, right: widthX * 0.03),
              child: SizedBox(
                height: heightX * 0.23,
                //width: widthX * 0.9,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: availableTime.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 3 / 2),
                    itemBuilder: (context, int index) {
                      String timeSlot = availableTime[index];
                      bool isSelected = timeSlot == selectedTimeSlot;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTimeSlot = timeSlot;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? kSecondaryColor
                                  : kContainerColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(width: 2, color: kPrimaryColor)),
                          child: Center(
                              child: Text(
                            timeSlot,
                            style: smallTextStyle,
                          )),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: widthX * 0.03,
                  right: widthX * 0.03,
                  top: heightX * 0.03),
              child: Text('Fill Out Your Details',
                  style: mediumTextStyle.copyWith(
                      color: kPrimaryColor, fontSize: widthX * 0.05)),
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
                    onPress: () {
                      setState(() {
                        serviceType = 'Salon';
                        print(serviceType);
                      });
                    },
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(
                        fontSize: widthX * 0.048,
                        color: serviceType == 'Salon'
                            ? kPrimaryColor
                            : kWhiteColor),
                    btnColor: serviceType == 'Salon'
                        ? kSecondaryColor
                        : kPrimaryColor,
                  ),
                  SizedBox(
                    width: widthX * 0.03,
                  ),
                  CustomButton(
                    height: heightX * 0.06,
                    width: widthX * 0.44,
                    text: 'Home',
                    onPress: () {
                      setState(() {
                        serviceType = 'Home';
                        print(serviceType);
                      });
                    },
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(
                        fontSize: widthX * 0.048,
                        color:
                            serviceType == 'Home' ? kPrimaryColor : kWhiteColor),
                    btnColor: serviceType == 'Home'
                        ? kSecondaryColor
                        : kPrimaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: widthX * 0.05, right: widthX * 0.05, top: widthX * 0.03),
              child: Text(
                textAlign: TextAlign.justify,
                  serviceType == 'Home'
                      ? 'We only serve houses in 45km wide of area. Please check if your house meets this requirement before booking. Thank you for your understanding.'
                      : '',
                  style:
                      smallTextStyle.copyWith(fontWeight: FontWeight.normal)),
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
                if(selectedDate ==null ){
                  Utils().showSnackBar(context, 'Please Select Date');
                }
                else if(selectedTimeSlot ==null ){
                  Utils().showSnackBar(context, 'Please Select Time');
                }
                else if (serviceType ==null){
                  Utils().showSnackBar(context, 'Please Select Service Type');
                }
                else {
                  String formattedDate =
                  DateFormat('dd/MM/yyyy').format(selectedDate);
                  var StringPrice = widget.serviceIndex['service_price'];
                  var price = int.tryParse(StringPrice);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            serviceName: widget.serviceIndex['service_name'],
                            servicePrice: price!,
                            time: selectedTimeSlot!,
                            date: formattedDate,
                            serviceType: serviceType!, imageUrl: widget.serviceIndex['image_url'],
                          )));
                }

              },
              borderRadius: heightX * 0.013,
              style: mediumTextStyle.copyWith(fontSize: widthX * 0.048),
              btnColor: kPrimaryColor,
            )),
          ],
        ),
      ),
    );
  }
}
