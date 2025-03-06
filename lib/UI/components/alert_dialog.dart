import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:flutter/material.dart';
import '../../core/constants/const_styles.dart';

class ShowAlertDialog extends StatelessWidget {
 final String message;
final VoidCallback onPress;
  const  ShowAlertDialog({
    required this.message,
      required this.onPress,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kWhiteColor,

      title: Text('Warning', style: mediumTextStyle.copyWith(color: Colors.red),
      ),
    content: Text(message, style: smallTextStyle.copyWith(fontWeight: FontWeight.normal),),
     actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('No', style: smallTextStyle,)),
        TextButton(onPressed: onPress, child: Text('Yes', style: smallTextStyle,)),
      ],
    );
  }
}

