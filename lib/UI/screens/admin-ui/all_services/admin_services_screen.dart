import 'package:beauty_salon/UI/screens/admin-ui/add_service/add_service.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../all_categories/all_categories_provider.dart';
import 'admin_services_provider.dart';

class AdminServicesScreen extends StatelessWidget {
  AdminServicesScreen({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final adminServicesProvider = Provider.of<AdminServicesProvider>(context);
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Add Services',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          allCategoriesProvider.getCategories();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddService()));

        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Passwords')
              .where('user_id', isEqualTo: currentUser!.uid)
              .snapshots(),
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
                          color: kPrimaryColor,
                          child: ListTile(
                            leading: Container(
                              height: heightX * 0.07,
                              width: heightX * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshot
                                          .data.docs[index]
                                      ['image_url'],)
                                  )
                              ),

                            ),
                            title: Text(
                              snapshot.data.docs[index]['Account Name'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data.docs[index]['Account Password'],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             UpdateScreen(
                                      //               accountName: snapshot
                                      //                   .data.docs[index]
                                      //               ['Account Name'],
                                      //               docId: snapshot
                                      //                   .data.docs[index].id,
                                      //               accountPassword: snapshot
                                      //                   .data.docs[index]
                                      //               ['Account Password'], imageUrl: snapshot
                                      //                 .data.docs[index]
                                      //             ['image_url'],
                                      //             )));
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
                                      adminServicesProvider.deletePassword(snapshot.data.docs[index].id);
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