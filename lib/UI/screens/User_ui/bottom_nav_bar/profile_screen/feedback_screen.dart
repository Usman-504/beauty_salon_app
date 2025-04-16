import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../res/colors.dart';
import '../../../../../utils/styles.dart';
import 'feedback_provider.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: AppColors.whiteColor,
            )),
        centerTitle: true,
        title: Text('Feedback',
            style: secondaryTextStyle.copyWith(
                color: AppColors.whiteColor, fontSize: widthX * 0.063)),
      ),
      body: Consumer<FeedbackProvider>(
       builder: (context, vm, child) {
         return Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             CustomTextField(hintText: 'Your Name', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: vm.nameController,),
             CustomTextField(hintText: 'Your Email', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: vm.emailController,),
             CustomTextField(hintText: 'Your Message', maxWidth: widthX * 0.9, maxHeight: heightX * 0.5, maxLines: 5, controller: vm.messageController,),
             CustomButton(height: heightX * 0.06, width: widthX * 0.9, text: 'Send', borderRadius: 10, onPress: (){
               vm.feedBack(context);
             }, style: mediumTextStyle, btnColor: AppColors.primaryColor,)
           ],
         );
       },
      ),
    );
  }
}