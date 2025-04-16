import 'dart:io';
import 'package:beauty_salon/UI/screens/salon_owner_ui/bottom_nav_bar/salon_owner_bottom_nav_bar.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../res/colors.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/snackbar.dart';
import 'add_category_provider.dart';


class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<AddCategoryProvider>().clearFields());
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          ' Add Category',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AddCategoryProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      vm.pickImage();
                    },
                    child: Container(
                      height: heightX * 0.3,
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
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: Center(
                        child: vm.file == null
                            ? const Text(
                                'Upload Image/Icon',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                  CustomTextField(
                      controller: vm.categoryNameController,
                      hintText: 'Category Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),

                  CustomButton(
                    height: heightX * 0.08,
                    width: widthX * 0.9,
                    text: 'Add Category',
                    borderRadius: 9,
                    onPress: () async {
                      try {
                        String? validation = vm.validation();
                        if (validation != null) {
                          Utils().showSnackBar(context, validation);
                        } else {
                          vm.addData();
                          Utils().showSnackBar(context, 'Category Adding...');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SalonOwnerBottomNavBar()));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    style: mediumTextStyle,
                    btnColor: AppColors.primaryColor,
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
