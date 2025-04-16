import 'dart:io';
import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/profile_screen/update_profile_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../res/colors.dart';
import '../../../../../res/components/custom_button.dart';
import '../../../../../res/components/custom_textfield.dart';
import '../../../../../res/components/password_textfield.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/assets.dart';

class EditProfileScreen extends StatefulWidget {

final String name;
final String email;
final String phoneNo;
final String imageUrl;
final String docId;

  const EditProfileScreen({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.imageUrl,
    required this.docId,
    super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNoController;
   TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
     nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneNoController = TextEditingController(text: widget.phoneNo);

  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final updateProfileInfoProvider = Provider.of<UpdateProfileInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: AppColors.whiteColor,
            )),
        centerTitle: true,
        title: Text('Update Profile',
            style: secondaryTextStyle.copyWith(
                color: AppColors.whiteColor, fontSize: widthX * 0.063)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
               children: [
                 Container(
                   height: heightX * 0.25,
                 ),
                 Positioned(
                   top: heightX * 0.03,
                   left: widthX * 0.3,
                   child: Container(
                     height: heightX * 0.18,
                     width: heightX * 0.18,
                     decoration: BoxDecoration(
                         border: Border.all(color: AppColors.primaryColor, width: 3),
                         shape: BoxShape.circle),
                   ),
                 ),
                 Positioned(
                   top: heightX * 0.04,
                   left: widthX * 0.32,
                   child: Container(
                     height: heightX * 0.16,
                     width: heightX * 0.16,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         fit: BoxFit.cover,
                         image: updateProfileInfoProvider.file != null
                             ? FileImage(File(updateProfileInfoProvider.file!.path))
                             : (widget.imageUrl.isNotEmpty
                             ? NetworkImage(widget.imageUrl)
                             : const AssetImage(Assets.dp) as ImageProvider),
                       ),
                     ),

                   ),
                 ),
                 Positioned(
                   top: heightX * 0.15,
                   left: widthX * 0.55,
                   child: Container(
                     height: heightX * 0.05,
                     width: heightX * 0.05,
                     decoration: const BoxDecoration(
                       color: AppColors.secondaryColor,
                       shape: BoxShape.circle,
                     ),
                     child: GestureDetector(
                         onTap: (){
                           updateProfileInfoProvider.pickImage();
                         },
                         child: const Icon(Icons.camera_alt, color: Colors.white,)),
                   ),
                 ),
               ],
              ),
              CustomTextField(hintText: 'Update Name', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: nameController),
              CustomTextField(hintText: 'Update phone No', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: phoneNoController),
              CustomTextField(hintText: 'Update Email', maxWidth: widthX * 0.9, maxHeight: heightX * 0.08, controller: emailController),
              SizedBox(
                height: heightX * 0.04,
              ),
              Padding(
                padding:  EdgeInsets.only(left: widthX * 0.05),
                child: Text('To Save Changes First Enter Your Password:', style: smallTextStyle,),
              ),
              SizedBox(
                height: heightX * 0.009,
              ),
              PasswordTextField(controller: passwordController),
              Center(
                child: CustomButton(height: heightX * 0.06, width: widthX * 0.9, text: 'Save', borderRadius: 10, onPress: (){
                  updateProfileInfoProvider.updateUserDetails(nameController.text.trim(),  emailController.text.trim(), phoneNoController.text.trim(), widget.docId, passwordController.text.trim(), context);
                }, style: mediumTextStyle, btnColor: AppColors.primaryColor,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
