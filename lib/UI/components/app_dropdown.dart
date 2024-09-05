import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../core/constants/const_colors.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  });

  final List<String> items;
  final String labelText;
  final String? selectedItem;
  final void Function(String?)? onChanged;

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return SizedBox(
      height: heightX * 0.08,
     width: widthX * 0.9,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
          menuProps: const MenuProps(
          // backgroundColor: Colors.black,
          ),
          itemBuilder: (context, item, isSelected) {
            return Container(
              color: kContainerColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                item,
                style: mediumTextStyle.copyWith(color: kPrimaryColor),
              ),
            );
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: mediumTextStyle.copyWith(color: kPrimaryColor),
          dropdownSearchDecoration: InputDecoration(
            hintText: widget.labelText,
            filled: true,
            fillColor:  kContainerColor,
            contentPadding: const EdgeInsets.only(left: 10, top: 15),
            hintStyle: mediumTextStyle.copyWith(color: kPrimaryColor),
            // floatingLabelStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            ),
          ),
        ),
        dropdownButtonProps: const DropdownButtonProps(
          icon: Icon(
            Icons.arrow_drop_down,
            color: kPrimaryColor,
          ),
        ),
        items: widget.items,
        onChanged: widget.onChanged,
        selectedItem: widget.selectedItem,
      ),
    );
  }
}