import 'dart:io';
import 'package:beauty_salon/UI/components/app_dropdown.dart';
import 'package:beauty_salon/UI/screens/admin-ui/add_category/add_category.dart';
import 'package:beauty_salon/UI/screens/admin-ui/add_category/add_category_provider.dart';
import 'package:beauty_salon/UI/screens/admin-ui/bottom_nav_bar/admin_bottom_nav_bar.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/snackbar.dart';
import '../all_categories/all_categories_provider.dart';
import '../all_categories/all_categories_screen.dart';
import 'add_service_provider.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<AddServiceProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final addServiceProvider =
        Provider.of<AddServiceProvider>(context, listen: false);
    final allCategoriesProvider =
        Provider.of<AllCategoriesProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kContainerColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Add Service',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AddServiceProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 20, bottom: 8),
                    child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCategory()));
                        },
                        child: Text('Add Category', style: mediumTextStyle.copyWith(color: kPrimaryColor, decoration: TextDecoration.underline, decorationThickness: 2),)),
                  ),
                  Center(
                    child: AppDropDown(
                        labelText: 'Select Category',
                        items: allCategoriesProvider.categoryList.isNotEmpty ? allCategoriesProvider.categoryList : ['No categories found'],
                        onChanged: addServiceProvider.dropDownCategory
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        vm.pickImage();
                      },
                      child: Container(
                        height: heightX * 0.25,
                        width: widthX * 0.9,
                        decoration: BoxDecoration(
                          image: vm.file != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(vm.file!.path)))
                              : null,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Center(
                          child: vm.file == null
                              ? const Text(
                                  'Upload Image/Icon',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                  CustomTextField(
                      controller: vm.serviceNameController,
                      hintText: 'Service Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                      controller: vm.servicePriceController,
                      hintText: 'Service Price',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                    maxLines: 5,
                      controller: vm.serviceDescriptionController,
                      hintText: 'Service Description',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.5),
                  Center(
                    child: CustomButton(
                      height: heightX * 0.08,
                      width: widthX * 0.9,
                      text: 'Add Service',
                      borderRadius: 9,
                      onPress: () async {
                        try {
                          String? validation = vm.validation();
                          if (validation != null) {
                            Utils().showSnackBar(context, validation);
                          } else {
                            vm.addData(addServiceProvider.selectedCategory!);
                            Utils().showSnackBar(context, 'Service Adding...');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminBottomNavBar()));
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      style: mediumTextStyle,
                      btnColor: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
