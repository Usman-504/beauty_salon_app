import 'package:beauty_salon/UI/components/custom_banner.dart';
import 'package:beauty_salon/UI/components/header.dart';
import 'package:beauty_salon/UI/components/side_drawer.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../favourite/fav_provider.dart';
import '../services/all_services/all_services.dart';
import '../services/services_details/service_details.dart';
import '../services/services_list/services_list.dart';
import '../services/sub_services/sub_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final favProvider = Provider.of<FavProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      backgroundColor: kScaffoldColor,
      body: Column(
        children: [
          Header(scaffoldKey: _scaffoldKey,),
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
                          style: mediumTextStyle.copyWith(color: kPrimaryColor),
                        ),
                      ),
                      const CustomBanner(),
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
                                    color: kPrimaryColor,
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
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SubServices(
                                  //               services:
                                  //                   serviceCategories[index]
                                  //                       ['services'],
                                  //               text: serviceCategories[index]
                                  //                   ['title'],
                                  //             )));
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
                                      Image.asset(
                                        serviceCategories[index]['image'],
                                        height: heightX * 0.08,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        height: heightX * 0.01,
                                      ),
                                      Text(
                                        serviceCategories[index]['title'],
                                        style: mediumTextStyle.copyWith(
                                            fontSize: widthX * 0.052,
                                            color: kPrimaryColor),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => SubServices(
                                //               services: serviceCategories[4]
                                //                   ['services'],
                                //               text: serviceCategories[4]
                                //                   ['title'],
                                //             )));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See all',
                                    style: smallTextStyle,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: kPrimaryColor,
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
                                                    price:
                                                        'Rs. ${serviceCategories[0]['services'][index]['price']}/-',
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
                                              color: kPrimaryColor, width: 2),
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
                                                fontSize: widthX * 0.038),
                                          ),
                                          Container(
                                            height: heightX * 0.027,
                                            decoration: const BoxDecoration(
                                                color: kSecondaryColor,
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
                                                  'Rs. ${serviceCategories[0]['services'][index]['price']}/-',
                                                  style:
                                                      smallTextStyle.copyWith(
                                                          color: kPrimaryColor,
                                                          fontSize:
                                                              widthX * 0.033),
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
                                                    color: kPrimaryColor,
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


