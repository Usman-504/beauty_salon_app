import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../components/header.dart';
import '../../../../../components/side_drawer.dart';
import '../../../../salon_owner_ui/all_categories/all_categories_provider.dart';
import '../../bottom_nav_screen/bottom_nav_bar.dart';
import '../sub_services/sub_services.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllCategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    print(allCategoriesProvider.categoryList.length);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      backgroundColor: kScaffoldColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            scaffoldKey: _scaffoldKey,
          ),
          Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, top: heightX * 0.02),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBar()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: heightX * 0.04,
                      color: kPrimaryColor,
                    )),
                SizedBox(
                  width: widthX * 0.03,
                ),
                Text('All Services',
                    style: secondaryTextStyle.copyWith(
                        color: kPrimaryColor, fontSize: widthX * 0.063)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(heightX * 0.02),
              child: StreamBuilder(
                  stream: allCategoriesProvider.getServices(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      print('error');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data.docs.isEmpty) {
                      print('Empty');
                    }
                    if (snapshot != null && snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubServices(
                                                text: snapshot.data!.docs[index]
                                                    ['category_name'],
                                                subServices: allCategoriesProvider
                                                    .getSubServices(
                                                        allCategoriesProvider
                                                                .categoryList[
                                                            index]),
                                                catId: allCategoriesProvider
                                                    .categoryList[index],
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kContainerColor,
                                      border: Border.all(
                                          color: kPrimaryColor, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ColorFiltered(
                                          colorFilter: const ColorFilter.mode(
                                              kPrimaryColor, BlendMode.srcATop),
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                ['image_url'],
                                            height: heightX * 0.11,
                                          )),
                                      SizedBox(
                                        height: heightX * 0.02,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['category_name'],
                                        style: mediumTextStyle.copyWith(
                                            fontSize: widthX * 0.052,
                                            color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsets.all(heightX * 0.02),
          //     child: StreamBuilder(
          //         stream: allCategoriesProvider.getServices(),
          //         builder: (context, AsyncSnapshot snapshot) {
          //           if (snapshot.hasError) {
          //             print('error');
          //           }
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return const Center(child: CircularProgressIndicator());
          //           }
          //           if (snapshot.data.docs.isEmpty) {
          //             print('Empty');
          //           }
          //           if (snapshot != null && snapshot.data != null) {
          //             return Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: GridView.builder(
          //                   itemCount: allCategoriesProvider.searchResult.length,
          //                   gridDelegate:
          //                   const SliverGridDelegateWithFixedCrossAxisCount(
          //                     crossAxisCount: 2,
          //                     childAspectRatio: 2 / 2,
          //                     mainAxisSpacing: 10,
          //                     crossAxisSpacing: 10,
          //                   ),
          //                   itemBuilder: (context, int index) {
          //                     return GestureDetector(
          //                       onTap: () {
          //                         Navigator.push(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) => SubServices(
          //                                   text: snapshot.data!.docs[index]
          //                                   ['category_name'],
          //                                   subServices: allCategoriesProvider
          //                                       .getSubServices(
          //                                       allCategoriesProvider
          //                                           .categoryList[
          //                                       index]),
          //                                   catId: allCategoriesProvider
          //                                       .categoryList[index],
          //                                 )));
          //                       },
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                             color: kContainerColor,
          //                             border: Border.all(
          //                                 color: kPrimaryColor, width: 2),
          //                             borderRadius: BorderRadius.circular(10)),
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             ColorFiltered(
          //                                 colorFilter: const ColorFilter.mode(
          //                                     kPrimaryColor, BlendMode.srcATop),
          //                                 child: Image.network(
          //                                   allCategoriesProvider.searchResult[index]['image_url'],
          //                                   // snapshot.data!.docs[index]
          //                                   // ['image_url'],
          //                                   height: heightX * 0.11,
          //                                 )),
          //                             SizedBox(
          //                               height: heightX * 0.02,
          //                             ),
          //                             Text(
          //                              // snapshot.data!.docs[index]
          //                               allCategoriesProvider.searchResult[index]
          //                                ['category_name'],
          //                               style: mediumTextStyle.copyWith(
          //                                   fontSize: widthX * 0.052,
          //                                   color: kPrimaryColor),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     );
          //                   }),
          //             );
          //           }
          //           return const CircularProgressIndicator();
          //         }),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// child: StreamBuilder(
//     stream: allCategoriesProvider.getServices(),
//     builder: (context, AsyncSnapshot snapshot) {
//
//       if (snapshot.hasError) {
//         print('error');
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return
//           const Center(child: CircularProgressIndicator());
//
//       }
//       if (snapshot.data.docs.isEmpty) {
//         print('Empty');
//       }
//       if (snapshot != null && snapshot.data != null) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//               itemCount: snapshot.data!.docs.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 2 / 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//               ),
//               itemBuilder: (context, int index) {
//                 return GestureDetector(
//                   onTap: (){
//                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubServices(services: serviceCategories[index]['services'], text: serviceCategories[index]['title'],)));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: kContainerColor,
//                         border: Border.all(color: kPrimaryColor, width: 2),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ColorFiltered(
//                             colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcATop),
//                             child: Image.network(snapshot.data!.docs[index]['image_url'], height: heightX * 0.11,)),
//                         SizedBox(
//                           height: heightX * 0.02,
//                         ),
//                         Text(allCategoriesProvider.capitalizeFirstLetter(snapshot.data!.docs[index].id,),
//
//                           style: mediumTextStyle.copyWith(
//                               fontSize: widthX * 0.052, color: kPrimaryColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         );
//       }
//       return const CircularProgressIndicator();
//     }),
// GridView.builder(
//     itemCount: serviceCategories.length,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       childAspectRatio: 2 / 2,
//       mainAxisSpacing: 10,
//       crossAxisSpacing: 10,
//     ),
//     itemBuilder: (context, int index) {
//       return GestureDetector(
//         onTap: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=> SubServices(services: serviceCategories[index]['services'], text: serviceCategories[index]['title'],)));
//         },
//         child: Container(
//           decoration: BoxDecoration(
//               color: kContainerColor,
//               border: Border.all(color: kPrimaryColor, width: 2),
//               borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ColorFiltered(
//                   colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcATop),
//                   child: Image.network(snapshot.data!.docs[index]['image_url'], height: heightX * 0.11,)),
//               SizedBox(
//                 height: heightX * 0.02,
//               ),
//               Text(allCategoriesProvider.capitalizeFirstLetter(snapshot.data!.docs[index].id,),
//
//                 style: mediumTextStyle.copyWith(
//                     fontSize: widthX * 0.052, color: kPrimaryColor),
//               ),
//               // Image.asset(
//               //   serviceCategories[index]['image'],
//               //   height: heightX * 0.11,
//               //   color: kPrimaryColor,
//               // ),
//               // SizedBox(
//               //   height: heightX * 0.02,
//               // ),
//               // Text(
//               //   serviceCategories[index]['title'],
//               //   style: mediumTextStyle.copyWith(
//               //       fontSize: widthX * 0.052, color: kPrimaryColor),
//               // ),
//             ],
//           ),
//         ),
//       );
//     }),
