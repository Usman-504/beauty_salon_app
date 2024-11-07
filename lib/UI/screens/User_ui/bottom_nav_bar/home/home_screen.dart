import 'package:beauty_salon/UI/components/custom_banner.dart';
import 'package:beauty_salon/UI/components/header.dart';
import 'package:beauty_salon/UI/components/side_drawer.dart';
import 'package:beauty_salon/UI/screens/User_ui/bottom_nav_bar/services/services_details/service_details.dart';
import 'package:beauty_salon/UI/screens/admin-ui/all_categories/all_categories_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../admin-ui/all_services/admin_services_provider.dart';
import '../../cart_screen/cart_provider.dart';
import '../../favourite/fav_provider.dart';
import '../services/all_services/all_services.dart';
import '../services/sub_services/sub_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CartProvider>(context, listen: false).fetchAndDeleteExpiredItems();});
    Provider.of<AllCategoriesProvider>(context, listen: false).getCategories();
    Provider.of<AllCategoriesProvider>(context, listen: false)
        .getCategoryName();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final favProvider = Provider.of<FavProvider>(context, listen: false);
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(
      context,
    );
    final allServicesProvider = Provider.of<AdminServicesProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      backgroundColor: kScaffoldColor,
      body: Column(
        children: [
          Header(
            scaffoldKey: _scaffoldKey,
          ),
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
                      StreamBuilder(
                        stream: allCategoriesProvider.getServices(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print('error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Center(
                                child: Text('No data available'));
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            print('Empty');
                          }
                          if (snapshot.data != null) {
                            return Expanded(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length - 3,
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
                                                builder:
                                                    (context) => SubServices(
                                                          text: snapshot.data!
                                                                  .docs[index]
                                                              ['category_name'],
                                                          subServices: allCategoriesProvider
                                                              .getSubServices(
                                                                  allCategoriesProvider
                                                                          .categoryList[
                                                                      index]),
                                                          catId: allCategoriesProvider
                                                                  .categoryList[
                                                              index],
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
                                              MainAxisAlignment.center,
                                          children: [
                                            ColorFiltered(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        kPrimaryColor,
                                                        BlendMode.srcATop),
                                                child: Image.network(
                                                  snapshot.data!.docs[index]
                                                      ['image_url'],
                                                  height: heightX * 0.08,
                                                )),
                                            SizedBox(
                                              height: heightX * 0.01,
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
                        },
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
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubServices(
                                            text: allCategoriesProvider
                                                        .categoryNameList
                                                        .length >
                                                    3
                                                ? allCategoriesProvider
                                                    .categoryNameList[3]
                                                : '',
                                            subServices: allCategoriesProvider
                                                .getSubServices(
                                                    allCategoriesProvider
                                                        .categoryList[3]),
                                            catId: allCategoriesProvider
                                                .categoryList[3])));
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
                      StreamBuilder(
                        stream: allCategoriesProvider.getSubServices(
                            allCategoriesProvider.categoryList.length > 3
                                ? allCategoriesProvider.categoryList[3]
                                : null),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print('error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Center(
                                child: Text('No data available'));
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            print('Empty');
                          }
                          if (snapshot.data != null) {
                            return Expanded(
                              child: Consumer<FavProvider>(
                                builder: (context, vm, child) {
                                  return GridView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length - 2,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 2 / 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                      ),
                                      itemBuilder: (context, int index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            Map<String, dynamic>? documentData =
                                                await allServicesProvider
                                                    .fetchDocumentAsMap(
                                                        allCategoriesProvider
                                                                .categoryList[
                                                            3],
                                                        snapshot.data!
                                                            .docs[index].id);
                                            if(documentData != null){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ServiceDetails(
                                                          title: snapshot.data!
                                                              .docs[index]
                                                          ['service_name'],
                                                          imageUrl: snapshot.data!
                                                              .docs[index]
                                                          ['image_url'],
                                                          price: snapshot.data!.docs[index]['service_price'],
                                                          description: snapshot
                                                              .data!
                                                              .docs[index]
                                                          ['service_description'],

                                                           catId: allCategoriesProvider.categoryList[3], docId:snapshot
                                                          .data!
                                                          .docs[index].id,)));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kContainerColor,
                                                border: Border.all(
                                                    color: kPrimaryColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: heightX * 0.1,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['image_url'])),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['service_name'],
                                                  style:
                                                      smallTextStyle.copyWith(
                                                          fontSize:
                                                              widthX * 0.035),
                                                ),
                                                Container(
                                                  height: heightX * 0.027,
                                                  decoration: const BoxDecoration(
                                                      color: kSecondaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Rs. ${snapshot.data!.docs[index]['service_price']}/-',
                                                        style: smallTextStyle
                                                            .copyWith(
                                                                color:
                                                                    kPrimaryColor,
                                                                fontSize:
                                                                    widthX *
                                                                        0.038),
                                                      ),
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     favProvider
                                                      //             .favServices
                                                      //             .contains(
                                                      //                 index)
                                                      //         ? favProvider
                                                      //             .removeItem(
                                                      //                 index)
                                                      //         : favProvider
                                                      //             .addItem(
                                                      //                 index);
                                                      //   },
                                                      //   child: Icon(
                                                      //     vm.favServices
                                                      //             .contains(
                                                      //                 index)
                                                      //         ? Icons.favorite
                                                      //         : Icons
                                                      //             .favorite_border,
                                                      //     size: heightX * 0.025,
                                                      //     color: kPrimaryColor,
                                                      //   ),
                                                      // ),
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
                            );
                          }
                          return const CircularProgressIndicator();
                        },
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
