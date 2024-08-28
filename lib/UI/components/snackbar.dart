import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:flutter/material.dart';

class Utils {
  void cartSnackBar(
      BuildContext context, String message, String text, VoidCallback onPress) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kButtonColor,
        action: SnackBarAction(
            label: text, textColor: Colors.white, onPressed: onPress),
      ),
    );
  }

  void showSnackBar(
      BuildContext context, String message, ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kButtonColor,
      ),
    );
  }
}
