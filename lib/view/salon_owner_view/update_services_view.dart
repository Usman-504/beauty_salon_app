import 'dart:io';
import 'package:beauty_salon/view/salon_owner_view/salon_owner_bottom_nav_bar.dart';
import 'package:beauty_salon/view_model/salon_owner_view_model/update_services_view_model.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/custom_textfield.dart';
import '../../view_model/salon_owner_view_model/add_service_view_model.dart';
import '../../view_model/salon_owner_view_model/all_categories_view_model.dart';

class UpdateServicesScreen extends StatefulWidget {

  String? serviceName;
  String? docId;
  String? categoryName;
  String? imageUrl;
  int? price;
  String? description;

  UpdateServicesScreen(
      {required this.serviceName,
        required this.imageUrl,
        required this.categoryName,
        required this.price,
        required this.description,
        required this.docId,
        super.key});

  @override
  State<UpdateServicesScreen> createState() => _UpdateServicesScreenState();
}

class _UpdateServicesScreenState extends State<UpdateServicesScreen> {
  late TextEditingController _categoryNameController;
  late TextEditingController _serviceNameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;


  @override
  void initState() {
    super.initState();

    _categoryNameController = TextEditingController(text: widget.categoryName);
    _serviceNameController = TextEditingController(text: widget.serviceName);
    _priceController = TextEditingController(text: widget.price.toString());
    _descriptionController = TextEditingController(text: widget.description);
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
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context,);
   final addServiceProvider = Provider.of<AddServiceProvider>(context, listen: false);
    print('Rebuild');
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          allCategoriesProvider.capitalizeFirstLetter(widget.serviceName.toString()),
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<UpdateServicesProvider>(
        builder: (context, vm, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CustomTextField(
                  //     controller: _categoryNameController,
                  //     // vm.accountNameController..text = '${widget.accountName.toString()}',
                  //     hintText: 'Category Name',
                  //     maxWidth: widthX * 0.9,
                  //     maxHeight: heightX * 0.08),

                  GestureDetector(
                    onTap: () async {
                      vm.pickImage();
                    },
                    child: Container(
                      height: heightX * 0.25,
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
                          'Upload Image',
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
                      controller: _serviceNameController,
                      // vm.accountNameController..text = '${widget.accountName.toString()}',
                      hintText: 'Service Name',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                    keyBoardType: TextInputType.number,
                      controller: _priceController,
                      // vm.accountNameController..text = '${widget.accountName.toString()}',
                      hintText: 'Price',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.08),
                  CustomTextField(
                      maxLines: 5,
                      controller: _descriptionController,
                      hintText: 'Service Description',
                      maxWidth: widthX * 0.9,
                      maxHeight: heightX * 0.5),
                  CustomButton(
                    height: heightX * 0.08,
                    width: widthX * 0.9,
                    text: 'Update Service',
                    borderRadius: 9,
                    onPress: () {

                      vm.updateServiceData(widget.docId!, widget.categoryName!, _serviceNameController, _priceController, _descriptionController,
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