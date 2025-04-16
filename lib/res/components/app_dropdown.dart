import 'package:beauty_salon/res/colors.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';


class AppDropDown extends StatefulWidget {
  const AppDropDown({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.selectedItem,
   required this.fillColor,
  });

  final List<String> items;
  final String labelText;
  final String? selectedItem;
  final Color fillColor;
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
              color: widget.fillColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                item,
                style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
              ),
            );
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: mediumTextStyle.copyWith(color: AppColors.primaryColor),
          dropdownSearchDecoration: InputDecoration(
            hintText: widget.labelText,
            filled: true,
            fillColor:  widget.fillColor,
            contentPadding: const EdgeInsets.only(left: 10, top: 15),
            hintStyle: mediumTextStyle.copyWith(color: AppColors.primaryColor),
            // floatingLabelStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
            ),
          ),
        ),
        dropdownButtonProps: const DropdownButtonProps(
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
          ),
        ),
        items: widget.items,
        onChanged: widget.onChanged,
        selectedItem: widget.selectedItem,
      ),
    );
  }
}