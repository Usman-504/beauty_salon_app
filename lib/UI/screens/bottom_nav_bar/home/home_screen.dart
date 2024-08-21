import 'package:beauty_salon/UI/components/header.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/service_categories.dart';
import 'package:beauty_salon/UI/screens/stylists/all_stylists.dart';
import 'package:beauty_salon/UI/screens/stylists/stylists_list.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stylists/stylists_details.dart';
import '../services/fav_provider.dart';
import '../services/service_details.dart';
import '../services/services_list.dart';
import '../services/sub_services.dart';

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
    final favProvider2 = Provider.of<FavProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          Header(

          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: heightX * 0.65,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: heightX * 0.015,
                        bottom: heightX * 0.015,
                        left: heightX * 0.02,
                        right: heightX * 0.02,
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
                                          const ServiceCategories()));
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: widthX * 0.03, right: widthX * 0.03),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: heightX * 0.015,
                        bottom: heightX * 0.015,
                        left: heightX * 0.02,
                        right: heightX * 0.02,
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
                                            text: serviceCategories[4]['title'],
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: widthX * 0.03, right: widthX * 0.03),
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
                                                    title:
                                                        serviceCategories[0]
                                                                ['services'][index]
                                                            ['title'],
                                                    imageUrl:
                                                        serviceCategories[0]
                                                                ['services'][index]
                                                            ['image'],
                                                    price:
                                                        serviceCategories[0]
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
                                                            ['staticIcon'], index: serviceCategories[0]['services'][index],
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
                                                              ['services'][index]
                                                          ['image'])),
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
                                                      ['services'][index]['price'],
                                                  style:
                                                      smallTextStyle.copyWith(
                                                          color: kButtonColor,
                                                          fontSize:
                                                              heightX * 0.016),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    favProvider2.favItems
                                                            .contains(index)
                                                        ? favProvider2
                                                            .removeItem(index)
                                                        : favProvider2
                                                            .addItem(index);
                                                  },
                                                  child: Icon(
                                                    vm.favItems.contains(index)
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: heightX * 0.015,
                        bottom: heightX * 0.015,
                        left: heightX * 0.02,
                        right: heightX * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Stylists',
                            style: smallTextStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllStylists()));
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: widthX * 0.03, right: widthX * 0.03),
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: stylists.length - 1,
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
                                          builder: (context) => StylistsDetails(
                                                name: stylists[index]['name'],
                                                category: stylists[index]
                                                    ['category'],
                                                image: stylists[index]['image'],
                                                about: stylists[index]['about'],
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kContainerColor,
                                      border: Border.all(
                                          color: kButtonColor, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: heightX * 0.126,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  stylists[index]['image'])),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: heightX * 0.02,
                                      // ),
                                      // Text(
                                      //   stylists[index]['category'],
                                      //   style: smallTextStyle.copyWith(
                                      //       fontSize: heightX * 0.018),
                                      // ),
                                      Container(
                                        height: heightX * 0.027,
                                        width: widthX * 0.5,
                                        decoration: const BoxDecoration(
                                            color: kCircleAvatorColor,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8))),
                                        child: Center(
                                          child: Text(
                                            stylists[index]['name'],
                                            style: smallTextStyle.copyWith(
                                                color: kButtonColor,
                                                fontSize: heightX * 0.023),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
