import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/header.dart';
import 'package:beauty_salon/UI/screens/favourite/fav_stylists_provider.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/all_services/all_services.dart';
import 'package:beauty_salon/UI/screens/stylists/all_stylists/all_stylists.dart';
import 'package:beauty_salon/UI/screens/stylists/stylists_list/stylists_list.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/assets.dart';
import '../../stylists/stylists_details/stylists_details.dart';
import '../../favourite/fav_provider.dart';
import '../services/services_details/service_details.dart';
import '../services/services_list/services_list.dart';
import '../services/sub_services/sub_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final favProvider = Provider.of<FavProvider>(context, listen: false);
    final favStylistsProvider =
        Provider.of<FavStylistsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          Header(),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: heightX * 0.65,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: widthX * 0.03, right: widthX * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: heightX * 0.015,
                          bottom: heightX * 0.015,
                        ),
                        child: Text(
                          'Exclusive Offers',
                          style: mediumTextStyle.copyWith(color: kButtonColor),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: heightX * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kCircleAvatorColor,
                            ),
                          ),
                          // Positioned(
                          //   top: heightX * 0.005,
                          //   left: widthX * 0.02,
                          //   child: Text(
                          //     'Upto 50%',
                          //     style:
                          //         mediumTextStyle.copyWith(color: kButtonColor),
                          //   ),
                          // ),
                          Positioned(
                            top: heightX * 0.015,
                            left: widthX * 0.02,
                            child: Text(
                              'Look more beautiful and\nSave more discount.',
                              style: smallTextStyle.copyWith(color: kWhiteColor),
                            ),
                          ),
                          Positioned(
                            top: heightX * 0.09,
                            left: widthX * 0.02,
                            child: CustomButton(
                                height: heightX * 0.05,
                                width: widthX * 0.4,
                                text: 'Get offer now!',
                                borderRadius: 10,
                                onPress: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllServices()));
                                },
                                style: smallTextStyle.copyWith(
                                    color: kWhiteColor)),
                          ),
                          Positioned(
                            left: widthX * 0.7,
                            // right: widthX * 0.002,
                            child: Container(
                              height: heightX * 0.25,
                              width: widthX * 0.25,
                              decoration: BoxDecoration(
                                color: kButtonColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                              top: heightX * 0.006,
                              left: widthX * 0.57,
                              child: Image.asset(Assets.homeScreenPic)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: heightX * 0.015,
                          bottom: heightX * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Our Services',
                              style: smallTextStyle,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllServices()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See all',
                                    style: smallTextStyle,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: kButtonColor,
                                    size: heightX * 0.025,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: serviceCategories.length - 3,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
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
                                                services:
                                                    serviceCategories[index]
                                                        ['services'],
                                                text: serviceCategories[index]
                                                    ['title'],
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kContainerColor,
                                      border: Border.all(
                                          color: kButtonColor, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        serviceCategories[index]['image'],
                                        height: heightX * 0.08,
                                        color: kButtonColor,
                                      ),
                                      SizedBox(
                                        height: heightX * 0.01,
                                      ),
                                      Text(
                                        serviceCategories[index]['title'],
                                        style: mediumTextStyle.copyWith(
                                            fontSize: heightX * 0.025,
                                            color: kButtonColor),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: heightX * 0.015,
                          bottom: heightX * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured Services',
                              style: smallTextStyle,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubServices(
                                              services: serviceCategories[4]
                                                  ['services'],
                                              text: serviceCategories[4]
                                                  ['title'],
                                            )));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See all',
                                    style: smallTextStyle,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: kButtonColor,
                                    size: heightX * 0.025,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Consumer<FavProvider>(
                          builder: (context, vm, child) {
                            return GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    serviceCategories[0]['services'].length - 2,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
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
                                              builder: (context) =>
                                                  ServiceDetails(
                                                    title: serviceCategories[0]
                                                            ['services'][index]
                                                        ['title'],
                                                    imageUrl:
                                                        serviceCategories[0]
                                                                ['services']
                                                            [index]['image'],
                                                    price: serviceCategories[0]
                                                            ['services'][index]
                                                        ['price'],
                                                    description:
                                                        serviceCategories[0]
                                                                    ['services']
                                                                [index]
                                                            ['description'],
                                                    favIcon:
                                                        serviceCategories[0]
                                                                    ['services']
                                                                [index]
                                                            ['staticIcon'],
                                                    index: serviceCategories[0]
                                                        ['services'][index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kContainerColor,
                                          border: Border.all(
                                              color: kButtonColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: heightX * 0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(8),
                                                      topLeft:
                                                          Radius.circular(8)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      serviceCategories[0]
                                                              ['services']
                                                          [index]['image'])),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: heightX * 0.02,
                                          // ),
                                          Text(
                                            serviceCategories[0]['services']
                                                [index]['title'],
                                            style: smallTextStyle.copyWith(
                                                fontSize: heightX * 0.018),
                                          ),
                                          Container(
                                            height: heightX * 0.027,
                                            decoration: const BoxDecoration(
                                                color: kCircleAvatorColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  serviceCategories[0]
                                                          ['services'][index]
                                                      ['price'],
                                                  style:
                                                      smallTextStyle.copyWith(
                                                          color: kButtonColor,
                                                          fontSize:
                                                              heightX * 0.016),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    favProvider.favServices
                                                            .contains(index)
                                                        ? favProvider
                                                            .removeItem(index)
                                                        : favProvider
                                                            .addItem(index);
                                                  },
                                                  child: Icon(
                                                    vm.favServices
                                                            .contains(index)
                                                        ? serviceCategories[0]
                                                                    ['services']
                                                                [index]
                                                            ['staticIcon2']
                                                        : serviceCategories[0]
                                                                    ['services']
                                                                [index]
                                                            ['staticIcon'],
                                                    size: heightX * 0.025,
                                                    color: kButtonColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     top: heightX * 0.015,
                      //     bottom: heightX * 0.015,
                      //     left: heightX * 0.02,
                      //     right: heightX * 0.02,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Top Stylists',
                      //         style: smallTextStyle,
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const AllStylists()));
                      //         },
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               'See all',
                      //               style: smallTextStyle,
                      //             ),
                      //             Icon(
                      //               Icons.arrow_forward,
                      //               color: kButtonColor,
                      //               size: heightX * 0.025,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //         left: widthX * 0.03, right: widthX * 0.03),
                      //     child: Consumer<FavStylistsProvider>(
                      //       builder: (context, vm, child) {
                      //         return GridView.builder(
                      //             scrollDirection: Axis.horizontal,
                      //             itemCount: stylists.length - 1,
                      //             gridDelegate:
                      //             const SliverGridDelegateWithFixedCrossAxisCount(
                      //               crossAxisCount: 1,
                      //               childAspectRatio: 2 / 2,
                      //               mainAxisSpacing: 10,
                      //               crossAxisSpacing: 10,
                      //             ),
                      //             itemBuilder: (context, int index) {
                      //               return GestureDetector(
                      //                 onTap: () {
                      //                   Navigator.push(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                           builder: (context) => StylistsDetails(
                      //                             name: stylists[index]['name'],
                      //                             category: stylists[index]
                      //                             ['category'],
                      //                             image: stylists[index]['image'],
                      //                             about: stylists[index]['about'],
                      //                           )));
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: kContainerColor,
                      //                       border: Border.all(
                      //                           color: kButtonColor, width: 2),
                      //                       borderRadius: BorderRadius.circular(10)),
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       Container(
                      //                         height: heightX * 0.126,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: const BorderRadius.only(
                      //                               topRight: Radius.circular(8),
                      //                               topLeft: Radius.circular(8)),
                      //                           image: DecorationImage(
                      //                               fit: BoxFit.cover,
                      //                               image: AssetImage(
                      //                                   stylists[index]['image'])),
                      //                         ),
                      //                       ),
                      //                       Container(
                      //                         height: heightX * 0.027,
                      //                         width: widthX * 0.5,
                      //                         decoration: const BoxDecoration(
                      //                             color: kCircleAvatorColor,
                      //                             borderRadius: BorderRadius.only(
                      //                                 bottomLeft: Radius.circular(8),
                      //                                 bottomRight:
                      //                                 Radius.circular(8))),
                      //                         child: Row(
                      //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                           children: [
                      //                             Text(
                      //                               stylists[index]['name'],
                      //                               style: smallTextStyle.copyWith(
                      //                                   color: kButtonColor,
                      //                                   fontSize: heightX * 0.023),
                      //                             ),
                      //                             GestureDetector(
                      //                               onTap: (){
                      //                                 favStylistsProvider.favStylists.contains(index) ? favStylistsProvider.removeItem(index) : favStylistsProvider.addItem(index);
                      //                               },
                      //
                      //                               child: Icon(
                      //                                 vm.favStylists.contains(index) ? stylists[index]['staticIcon2'] : stylists[index]['staticIcon'],
                      //                                 size: heightX * 0.025,
                      //                                 color: kButtonColor,
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //             });
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
