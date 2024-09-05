import 'package:beauty_salon/UI/screens/admin-ui/all_categories/all_categories_provider.dart';
import 'package:beauty_salon/UI/screens/admin-ui/update_category/update_category_screen.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_category/add_category.dart';
import '../add_category/add_category_provider.dart';


class AllCategoriesScreen extends StatelessWidget {
  AllCategoriesScreen({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    final addCategoriesProvider = Provider.of<AddCategoryProvider>(context);
    return Scaffold(
      backgroundColor: kContainerColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
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
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: kSecondaryColor,
                          child: ListTile(
                            leading: ColorFiltered(
                              colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcATop),
                              child: Image(image: NetworkImage(snapshot
                                          .data!.docs[index]['image_url'])),
                            ),
                            title: Text(
                              snapshot.data!.docs[index].id,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            // subtitle: Text(
                            //   snapshot.data.docs[index]['Account Password'],
                            //   style: const TextStyle(
                            //     color: Colors.white,
                            //   ),
                            // ),
                            trailing: SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCategoryScreen(categoryName: snapshot.data!.docs[index].id, docId: snapshot.data!.docs[index].id, imageUrl: snapshot.data!.docs[index]['image_url'],

                                                  )));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
allCategoriesProvider.deleteCategory(snapshot.data.docs[index].id);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}