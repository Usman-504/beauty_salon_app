import 'package:beauty_salon/UI/screens/admin-ui/add_service/add_service.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../User_ui/favourite/fav_provider.dart';
import '../all_categories/all_categories_provider.dart';
import '../update_services/update_services_screen.dart';
import 'admin_services_provider.dart';

class AdminServicesScreen extends StatefulWidget {
  AdminServicesScreen({super.key});

  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Provider.of<AllCategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final adminServicesProvider = Provider.of<AdminServicesProvider>(context);
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context,);
    // Provider.of<AllCategoriesProvider>(context, ).getCategories();
   // var category = allCategoriesProvider.categoryList[index];
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'All Services',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {

         // allCategoriesProvider.getCategories();
          // allCategoriesProvider.getSubCategories();
           //allCategoriesProvider.gets();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddService()));

        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body:

      ListView.builder(
        itemCount: allCategoriesProvider.categoryList.length,
        itemBuilder: (context, index){
       String catId = allCategoriesProvider.categoryList[index];
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('services').doc(catId).collection('subServices')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print('error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return
                  const Center(child: CircularProgressIndicator());

              }
              if (!snapshot.hasData || snapshot.data == null ) {
                return const Center(child: Text('No data available'));

              }
              if (snapshot.data.docs.isEmpty) {
                print('Empty');

              }

              if (snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                        child: Text(allCategoriesProvider.capitalizeFirstLetter('$catId: '), style: secondaryTextStyle.copyWith(color: kPrimaryColor),),
                      ),
                      SizedBox(height: heightX * 0.01,),
                      GridView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2.5,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: kContainerColor,
                                  border: Border.all(color: kPrimaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: heightX * 0.18,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                          NetworkImage(snapshot.data!.docs[index]['image_url'],)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {

                                              // FirebaseFirestore.instance.collection('services').snapshots();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateServicesScreen(serviceName: snapshot.data!.docs[index].id, imageUrl: snapshot
                                                              .data!.docs[index]
                                                          ['image_url'], categoryName: catId, price: snapshot.data!.docs[index]['service_price'], description: snapshot.data!.docs[index]['service_description'],

                                                          )));
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              adminServicesProvider.deleteService(catId, snapshot.data!.docs[index].id);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: heightX * 0.02,
                                  // ),
                                  Text(
                                      allCategoriesProvider.capitalizeFirstLetter(snapshot.data!.docs[index].id),
                                    style: smallTextStyle.copyWith(
                                        fontSize: widthX * 0.042),
                                  ),
                                  Container(
                                    height: heightX * 0.045,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: kSecondaryColor,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                    ),
                                    child: Center(
                                      child: Text('Rs. ${ snapshot.data!.docs[index]['service_price']}/-',
                                        style: smallTextStyle.copyWith(
                                            color: kPrimaryColor,
                                            fontSize: widthX * 0.038),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      // ListView.builder(
                      //     shrinkWrap: true, // Ensures ListView takes up minimal height
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: snapshot.data!.docs.length,
                      //     itemBuilder: (context, index) {
                      //       return Card(
                      //           color: kPrimaryColor,
                      //           child: ListTile(
                      //             leading: Container(
                      //               height: heightX * 0.07,
                      //               width: heightX * 0.07,
                      //               decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(9),
                      //                   image: DecorationImage(
                      //                       fit: BoxFit.cover,
                      //                       image: NetworkImage(snapshot
                      //                           .data!.docs[index]
                      //                       ['image_url'],)
                      //                   )
                      //               ),
                      //
                      //             ),
                      //             title: Text(
                      //               snapshot.data!.docs[index].id,
                      //               style: const TextStyle(
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 20),
                      //             ),
                      //             subtitle: Text(
                      //               snapshot.data!.docs[index]['service_price'],
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             trailing: SizedBox(
                      //               width: 70,
                      //               child: Row(
                      //                 children: [
                      //                   GestureDetector(
                      //                     onTap: () {
                      //
                      //                       // FirebaseFirestore.instance.collection('services').snapshots();
                      //                       Navigator.push(
                      //                           context,
                      //                           MaterialPageRoute(
                      //                               builder: (context) =>
                      //                                   UpdateServicesScreen(serviceName: snapshot.data!.docs[index].id, imageUrl: snapshot
                      //                                       .data!.docs[index]
                      //                                   ['image_url'], categoryName: catId, price: snapshot.data!.docs[index]['service_price'], description: snapshot.data!.docs[index]['service_description'],
                      //
                      //                                   )));
                      //                     },
                      //                     child: const Icon(
                      //                       Icons.edit,
                      //                       color: Colors.white,
                      //                     ),
                      //                   ),
                      //                   const SizedBox(
                      //                     width: 20,
                      //                   ),
                      //                   GestureDetector(
                      //                     onTap: () {
                      //                       adminServicesProvider.deleteService(catId, snapshot.data!.docs[index].id);
                      //                     },
                      //                     child: const Icon(
                      //                       Icons.delete,
                      //                       color: Colors.white,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ));
                      //     }),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            });
        },
      ),
    );
  }
}