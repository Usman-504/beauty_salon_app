import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/colors.dart';
import '../../res/components/alert_dialog.dart';
import '../../utils/styles.dart';
import 'add_category_view.dart';
import 'update_category_view.dart';
import '../../view_model/salon_owner_view_model/all_categories_view_model.dart';


class AllCategoriesScreen extends StatelessWidget {
  AllCategoriesScreen({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCategory()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: allCategoriesProvider.getServices(),
          builder: (context, AsyncSnapshot snapshot) {

            if (snapshot.hasError) {
              print('error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return
                const Center(child: CircularProgressIndicator());

            }
            if (snapshot.data.docs.isEmpty) {
              print('Empty');
            }
            if (snapshot != null && snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
child: GridView.builder(
    itemCount: snapshot.data!.docs.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2 / 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    itemBuilder: (context, int index) {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            border: Border.all(color: AppColors.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateCategoryScreen(categoryName: snapshot.data!.docs[index]['category_name'],  imageUrl: snapshot.data!.docs[index]['image_url'], catId: snapshot.data!.docs[index].id,

                                  )));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return  ShowAlertDialog(message: 'Are you sure you want to delete this Category?', onPress: () {
                              allCategoriesProvider.deleteCategory(snapshot.data.docs[index].id);
                              Navigator.pop(context);
                            },);
                          });

                    },
                    child: const Icon(
                      Icons.delete,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            ColorFiltered(
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcATop),
                child: Image.network(snapshot.data!.docs[index]['image_url'], height: heightX * 0.11,)),
            SizedBox(
              height: heightX * 0.02,
            ),
            Text( snapshot.data!.docs[index]['category_name'],
              style: mediumTextStyle.copyWith(
                  fontSize: widthX * 0.052, color: AppColors.primaryColor),
            ),
          ],
        ),
      );
    }),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}