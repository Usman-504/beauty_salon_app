import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/UI/components/snackbar.dart';
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
  final String? serviceName;
  final List? serviceNames;
  final int? servicePrice;
  final List<int>? servicePrices;
  final String? serviceImageUrl;
  final List? serviceImageUrls;
  final bool cart;
  final int cartLength;
  const BookAppointment({
     this.serviceName,
     this.servicePrice,
     this.serviceImageUrl,
    this.cart = false,
    this.cartLength = 1,
    super.key,
    this.serviceNames,
    this.servicePrices,
    this.serviceImageUrls
  });


  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  // var selectedDate = DateTime.now();
  // String? selectedTimeSlot;
  // String? serviceType;



  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    // final bookAppointmentProvider = Provider.of<BookAppointmentProvider>(context);
print('names ${widget.serviceNames}');
print('images ${widget.serviceImageUrls}');
print('prices ${widget.servicePrices}');
print('length ${widget.cartLength}');
    return ChangeNotifierProvider(
      create: (_)=>BookAppointmentProvider(),
      child: Consumer<BookAppointmentProvider>(
        builder: (context, vm, child) {
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
                            initialSelectedDate: vm.selectedDate,
                            selectionColor: kPrimaryColor,
                            selectedTextColor: kWhiteColor,
                            onDateChange: vm.onDateChange,
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
                          itemCount: vm.availableTime.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 3 / 2),
                          itemBuilder: (context, int index) {
                            TimeOfDay time = vm.availableTime[index];
                            String formattedTime = time.format(context);
                            DateTime now = DateTime.now();
                            TimeOfDay nowTime = TimeOfDay.now();
                            DateTime selectedDate = vm.selectedDate ?? DateTime.now();
                            bool isPast = selectedDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day))
                                && (time.hour < nowTime.hour || (time.hour == nowTime.hour && time.minute < nowTime.minute));
                            bool isSelected = formattedTime == vm.selectedTimeSlot;
                            bool isMultiSelected = vm.selectedTimeSlots.contains(formattedTime) ;

                            return GestureDetector(
                              onTap: isPast ? null : () {
                                if (!widget.cart) {
                                  vm.onTimeChange(formattedTime);
                                } else {
                                  if (!isMultiSelected && vm.selectedTimeSlots.length >= widget.cartLength) {
                                    Utils().showSnackBar(context, 'You can select only ${widget.cartLength} time slots');
                                  } else {
                                    vm.selectTimeSlot(formattedTime, widget.cartLength);
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isPast ? Colors.grey :
                                    isSelected || isMultiSelected
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
                      controller: vm.nameController,
                      hintText: 'Enter Name',
                      maxWidth: widthX * 0.92,
                      maxHeight: heightX * 0.07),
                  CustomTextField(
                      controller: vm.phoneController,
                      keyBoardType: TextInputType.number,
                      hintText: 'Enter Phone',
                      maxWidth: widthX * 0.92,
                      maxHeight: heightX * 0.07),
                  CustomTextField(
                      controller: vm.addressController,
                      maxLines: 3,
                      hintText: 'Enter Address',
                      maxWidth: widthX * 0.92,
                      maxHeight: heightX * 0.14),
                  CustomTextField(
                      controller: vm.messageController,
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
                            vm.Salon();
                          },
                          borderRadius: heightX * 0.013,
                          style: mediumTextStyle.copyWith(
                              fontSize: widthX * 0.048,
                              color: vm.serviceType == 'Salon'
                                  ? kPrimaryColor
                                  : kWhiteColor),
                          btnColor: vm.serviceType == 'Salon'
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
                            vm.Home();
                          },
                          borderRadius: heightX * 0.013,
                          style: mediumTextStyle.copyWith(
                              fontSize: widthX * 0.048,
                              color:
                              vm.serviceType == 'Home' ? kPrimaryColor : kWhiteColor),
                          btnColor: vm.serviceType == 'Home'
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
                        vm.serviceType == 'Home'
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
                          if(vm.validation(context, widget.cart, widget.cartLength)){
                            String formattedDate =
                            DateFormat('dd/MM/yyyy').format(vm.selectedDate!);
                            if(!widget.cart) {
                              vm.calculateTotalPrice(widget.servicePrice!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppointmentSummary(
                                        serviceName: widget.serviceName!,
                                        cart: widget.cart,
                                        servicePrice: widget.servicePrice!,
                                        time: vm.selectedTimeSlot!,
                                        date: formattedDate,
                                        serviceType: vm.serviceType!,
                                        imageUrl: widget.serviceImageUrl!,
                                        customerName: vm.nameController.text.trim(),
                                        customerAddress: vm.addressController.text.trim(),
                                        customerNumber: vm.phoneController.text.trim(),
                                        totalPrice: vm.totalPrice,
                                        customerMessage:vm.messageController.text.trim(),
                                        appointmentStatus: '', docId: '',
                                      )));
                            }
                            else{
                              vm.calculatePrice(widget.servicePrices!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppointmentSummary(
                                        serviceNames: widget.serviceNames!,
                                        cart: widget.cart,
                                        cartLength: widget.cartLength,
                                        servicePrices: widget.servicePrices!,
                                        timeSlots: vm.selectedTimeSlots,
                                        date: formattedDate,
                                        serviceType: vm.serviceType!,
                                        imageUrls: widget.serviceImageUrls!,
                                        customerName: vm.nameController.text.trim(),
                                        customerAddress: vm.addressController.text.trim(),
                                        customerNumber: vm.phoneController.text.trim(),
                                        totalPrice: vm.totalPrice,
                                        customerMessage:vm.messageController.text.trim(),
                                        appointmentStatus: '', docId: '',
                                      )));
                            }

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
        },
      ),
    );
  }
}
