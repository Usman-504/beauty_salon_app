import 'dart:io';
import 'package:beauty_salon/UI/screens/salon_owner_ui/bottom_nav_bar/salon_owner_bottom_nav_bar.dart';
import 'package:beauty_salon/UI/screens/salon_owner_ui/update_services/update_services_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../add_service/add_service_provider.dart';
import '../all_categories/all_categories_provider.dart';

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
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
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
                          color: kPrimaryColor,
                        ),
                      ),
                      child: Center(
                        child: vm.file == null && widget.imageUrl == null
                            ? const Text(
                          'Upload Image',
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