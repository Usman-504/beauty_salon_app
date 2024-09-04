import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/const_colors.dart';
import '../../generated/assets.dart';

class Data extends StatelessWidget {
  Data({super.key});

  TextEditingController cNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                controller: cNameController,
                hintText: 'Category',
                maxWidth: widthX * 0.9,
                maxHeight: heightX * 0.06),
            CustomTextField(
                controller: sNameController,
                hintText: 'Service Name',
                maxWidth: widthX * 0.9,
                maxHeight: heightX * 0.06),
            CustomTextField(
                controller: priceController,
                hintText: 'Price',
                maxWidth: widthX * 0.9,
                maxHeight: heightX * 0.06),
            CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxWidth: widthX * 0.9,
                maxHeight: heightX * 0.06),
            CustomButton(
                height: heightX * 0.06,
                width: widthX * 0.9,
                text: 'Submit',
                borderRadius: 20,
                onPress: () {
                  try {
                    FirebaseFirestore.instance
                        .collection('services')
                        .doc(cNameController.text.trim().toLowerCase())
                        .collection('subServices')
                        .doc(sNameController.text.trim().toLowerCase())
                        .set({
                      'Price': priceController.text.trim(),
                      'description': descriptionController.text.trim(),
                    });
                  }
                      catch(e){
                    print(e);
                      }
                },
                style: mediumTextStyle, btnColor: kPrimaryColor,)
          ],
        ),
      ),
    );
  }
}
