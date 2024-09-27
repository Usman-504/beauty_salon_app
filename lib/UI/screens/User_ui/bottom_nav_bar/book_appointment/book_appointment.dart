import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_button.dart';
import '../../AppointmentSummary/appointment_summary.dart';
import 'book_appointment_provider.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({required this.serviceName, required this.servicePrice, required this.serviceImageUrl, super.key});
  final String serviceName;
  final int servicePrice;
  final String serviceImageUrl;

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  // var selectedDate = DateTime.now();
  // String? selectedTimeSlot;
  // String? serviceType;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BookAppointmentProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final bookAppointmentProvider = Provider.of<BookAppointmentProvider>(context);

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
                      onDateChange: bookAppointmentProvider.onDateChange,
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookAppointmentProvider.availableTime.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 3 / 2),
                    itemBuilder: (context, int index) {
                      TimeOfDay time = bookAppointmentProvider.availableTime[index];
                      String formattedTime = time.format(context);
                      DateTime now = DateTime.now();
                      TimeOfDay nowTime = TimeOfDay.now();
                      DateTime selectedDate = bookAppointmentProvider.selectedDate;
                      bool isPast = selectedDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day))
                          && (time.hour < nowTime.hour || (time.hour == nowTime.hour && time.minute < nowTime.minute));

                      // TimeOfDay now = TimeOfDay.now();
                      // DateTime nowDateTime = DateTime(
                      //     DateTime.now().year,
                      //     DateTime.now().month,
                      //     DateTime.now().day,
                      //     now.hour,
                      //     now.minute);
                      // DateTime timeDateTime = DateTime(
                      //     DateTime.now().year,
                      //     DateTime.now().month,
                      //     DateTime.now().day,
                      //     time.hour,
                      //     time.minute);
                     // bool isPast = timeDateTime.isBefore(nowDateTime);
                    //  String timeSlot = bookAppointmentProvider.availableTime[index];
                      bool isSelected = formattedTime == bookAppointmentProvider.selectedTimeSlot;
                      return GestureDetector(
                        onTap: isPast ? null : () {
                          bookAppointmentProvider.onTimeChange(formattedTime);
                          // setState(() {
                          //   selectedTimeSlot = timeSlot;
                          // });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: isPast ? Colors.grey :
                              isSelected
                                  ? kSecondaryColor
                                  : kContainerColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(width: 2, color: kPrimaryColor)),
                          child: Center(
                              child: Text(
                                formattedTime,
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
              controller: bookAppointmentProvider.nameController,
                hintText: 'Enter Name',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.07),
            CustomTextField(
              controller: bookAppointmentProvider.phoneController,
                keyBoardType: TextInputType.number,
                hintText: 'Enter Phone',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.07),
            CustomTextField(
              controller: bookAppointmentProvider.addressController,
                maxLines: 3,
                hintText: 'Enter Address',
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.14),
            CustomTextField(
              controller: bookAppointmentProvider.messageController,
                hintText: 'Enter Message(Optional)',
                maxLines: 5,
                maxWidth: widthX * 0.92,
                maxHeight: heightX * 0.2),
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
                      bookAppointmentProvider.Salon();
                    },
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(
                        fontSize: widthX * 0.048,
                        color: bookAppointmentProvider.serviceType == 'Salon'
                            ? kPrimaryColor
                            : kWhiteColor),
                    btnColor: bookAppointmentProvider.serviceType == 'Salon'
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
                      bookAppointmentProvider.Home();
                    },
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(
                        fontSize: widthX * 0.048,
                        color:
                            bookAppointmentProvider.serviceType == 'Home' ? kPrimaryColor : kWhiteColor),
                    btnColor: bookAppointmentProvider.serviceType == 'Home'
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
                  bookAppointmentProvider.serviceType == 'Home'
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
                if(bookAppointmentProvider.validation(context)){
                  String formattedDate =
                  DateFormat('dd/MM/yyyy').format(bookAppointmentProvider.selectedDate);
                  bookAppointmentProvider.calculateTotalPrice(widget.servicePrice);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentSummary(
                            serviceName: widget.serviceName,
                            servicePrice: widget.servicePrice,
                            time: bookAppointmentProvider.selectedTimeSlot!,
                            date: formattedDate,
                            serviceType: bookAppointmentProvider.serviceType!, imageUrl: widget.serviceImageUrl, customerName: bookAppointmentProvider.nameController.text.trim(), customerAddress: bookAppointmentProvider.addressController.text.trim(), customerNumber: bookAppointmentProvider.phoneController.text.trim(), totalPrice: bookAppointmentProvider.totalPrice, customerMessage:bookAppointmentProvider.messageController.text.trim(), appointmentStatus: '', docId: '',
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
