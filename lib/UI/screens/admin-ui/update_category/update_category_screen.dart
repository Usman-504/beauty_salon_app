import 'dart:io';
import 'package:beauty_salon/UI/screens/admin-ui/all_categories/all_categories_provider.dart';
import 'package:beauty_salon/UI/screens/admin-ui/bottom_nav_bar/admin_bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/admin-ui/update_category/update_category_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';

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
    final allCategoryProvider = Provider.of<AllCategoriesProvider>(context);
    print('Rebuild');
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
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
                          color: kPrimaryColor,
                        ),
                      ),
                      child: Center(
                        child: vm.file == null && widget.imageUrl == null
                            ? const Text(
                          'Upload Icon',
                          style: TextStyle(
                              color: kPrimaryColor,
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminBottomNavBar()));
                      }, style: mediumTextStyle.copyWith(color: kContainerColor), btnColor: kPrimaryColor,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}