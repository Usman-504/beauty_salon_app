import 'dart:io';
import 'package:beauty_salon/UI/screens/salon_owner_ui/bottom_nav_bar/salon_owner_bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/salon_owner_ui/update_category/update_category_provider.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/custom_button.dart';
import '../../../../res/components/custom_textfield.dart';

class UpdateCategoryScreen extends StatefulWidget {

  String? categoryName;
  String? catId;
  String? imageUrl;

  UpdateCategoryScreen(
      {
        required this.categoryName,
        required this.imageUrl,
        required this.catId,
        super.key});

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  late TextEditingController _categoryNameController;


  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController(text: widget.categoryName);
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    print('Rebuild');
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text( widget.categoryName.toString(),
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<UpdateCategoryProvider>(
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: vm.file != null
                              ? FileImage(File(vm.file!.path))
                              : NetworkImage(widget.imageUrl!),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: Center(
                        child: vm.file == null && widget.imageUrl == null
                            ? const Text(
                          'Upload Icon',
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
                      controller: _categoryNameController,
                      // vm.accountNameController..text = '${widget.accountName.toString()}',
                      hintText: 'Category Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomButton(
                      height: heightX * 0.08,
                      width: widthX * 0.9,
                      text: 'Update Category',
                      borderRadius: 9,
                      onPress: () {
                        vm.updateData(widget.catId!, _categoryNameController.text.trim()
                            );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SalonOwnerBottomNavBar()));
                      }, style: mediumTextStyle.copyWith(color: AppColors.containerColor), btnColor: AppColors.primaryColor,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}