import 'package:beauty_salon/view/user_view/service_details_view.dart';
import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/custom_banner.dart';
import '../../res/components/header.dart';
import '../../res/components/side_drawer.dart';
import '../../view_model/salon_owner_view_model/all_categories_view_model.dart';
import '../../view_model/salon_owner_view_model/salon_owner_services_view_model.dart';
import '../../view_model/user_view_model/cart_view_model.dart';
import 'all_services_view.dart';
import 'sub_services_view.dart';

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

    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(
      context,
    );
    final allServicesProvider = Provider.of<SalonOwnerServicesProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      backgroundColor: AppColors.scaffoldColor,
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
                          style: mediumTextStyle.copyWith(color: AppColors.primaryColor),
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
                                    color: AppColors.primaryColor,
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
                                            color: AppColors.containerColor,
                                            border: Border.all(
                                                color: AppColors.primaryColor, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ColorFiltered(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        AppColors.primaryColor,
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
                                                  color: AppColors.primaryColor),
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
                                    color: AppColors.primaryColor,
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
                              child: GridView.builder(
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
                                            color: AppColors.containerColor,
                                            border: Border.all(
                                                color: AppColors.primaryColor,
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
                                                  color: AppColors.secondaryColor,
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
                                                            AppColors.primaryColor,
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
                                  }),
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
