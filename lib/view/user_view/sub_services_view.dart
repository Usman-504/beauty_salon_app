import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/header.dart';
import '../../res/components/side_drawer.dart';
import '../../utils/styles.dart';
import '../../view_model/salon_owner_view_model/all_categories_view_model.dart';
import 'service_details_view.dart';

class SubServices extends StatelessWidget {
  SubServices({ required this.text, required this.subServices, required this.catId, super.key});

  Stream subServices;
  String text;
  String catId;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
         Header(scaffoldKey: _scaffoldKey,),
          Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, top: heightX * 0.02),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  Icon(
                      Icons.arrow_back,
                      size: heightX * 0.04,
                      color: AppColors.primaryColor,
                    )),
                SizedBox(
                  width: widthX * 0.03,
                ),
                Text(allCategoriesProvider.capitalizeFirstLetter(text),
                    style: mediumTextStyle.copyWith(
                        color: AppColors.primaryColor, fontSize: heightX * 0.03)),
              ],
            ),
          ),
          StreamBuilder(stream: subServices, builder: (context, AsyncSnapshot snapshot){
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
            if (snapshot.data != null){
              return    Expanded(
                child: Padding(
                  padding: EdgeInsets.all(heightX * 0.02),
                  child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () async{
                           // Map<String, dynamic>? documentData = await allServicesProvider.fetchDocumentAsMap(catId, snapshot.data!.docs[index].id);
                           // if (documentData != null){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceDetails(
                                            title:  snapshot.data!.docs[index]['service_name'],
                                            imageUrl: snapshot.data!.docs[index]['image_url'],
                                            price:snapshot.data!.docs[index]['service_price'],
                                            description: snapshot.data!.docs[index]['service_description'],

                                             catId: catId, docId: snapshot.data!.docs[index].id,
                                          )));

                           // }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.containerColor,
                                border: Border.all(color: AppColors.primaryColor, width: 2),
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
                                        NetworkImage(snapshot.data!.docs[index]['image_url'])),
                                  ),
                                ),
                                // SizedBox(
                                //   height: heightX * 0.02,
                                // ),
                                Text(
                                  snapshot.data!.docs[index]['service_name'],
                                  style: smallTextStyle.copyWith(
                                      fontSize: widthX * 0.042),
                                ),
                                Container(
                                  height: heightX * 0.035,
                                  decoration: const BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Rs. ${snapshot.data!.docs[index]['service_price']}/-',
                                        style: smallTextStyle.copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: widthX * 0.038),
                                      ),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //     favProvider.favServices.contains(index) ? favProvider.removeItem(index) : favProvider.addItem(index);
                                      //   },
                                      //
                                      //   child: Icon(
                                      //     vm.favServices.contains(index) ? Icons.favorite : Icons.favorite_border,
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
                ),
              );
            }
            return CircularProgressIndicator();
          }),
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsets.all(heightX * 0.02),
          //     child: Consumer<FavProvider>(
          //       builder: (context, vm, child) {
          //         return GridView.builder(
          //             itemCount: services.length,
          //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               childAspectRatio: 2 / 2.5,
          //               mainAxisSpacing: 10,
          //               crossAxisSpacing: 10,
          //             ),
          //             itemBuilder: (context, int index) {
          //               return GestureDetector(
          //                 onTap: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) =>
          //                               ServiceDetails(
          //                                 title: services[index]
          //                                 ['title'],
          //                                 imageUrl: services[index]
          //                                 ['image'],
          //                                 price: 'Rs. ${services[index]
          //                                 ['price']}/-', description: services[index]['description'],
          //                                 favIcon: services[index]
          //                               ['staticIcon'], index: services[index],
          //                               )));
          //                 },
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                       color: kContainerColor,
          //                       border: Border.all(color: kPrimaryColor, width: 2),
          //                       borderRadius: BorderRadius.circular(10)),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Container(
          //                         height: heightX * 0.18,
          //                         decoration: BoxDecoration(
          //                           borderRadius: const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
          //                           image: DecorationImage(
          //                               fit: BoxFit.cover,
          //                               image:
          //                               AssetImage(services[index]['image'])),
          //                         ),
          //                       ),
          //                       // SizedBox(
          //                       //   height: heightX * 0.02,
          //                       // ),
          //                       Text(
          //                         services[index]['title'],
          //                         style: smallTextStyle.copyWith(
          //                             fontSize: widthX * 0.042),
          //                       ),
          //                       Container(
          //                         height: heightX * 0.035,
          //                         decoration: const BoxDecoration(
          //                             color: kSecondaryColor,
          //                             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
          //                         ),
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                           children: [
          //                             Text('Rs. ${services[index]['price']}/-',
          //                               style: smallTextStyle.copyWith(
          //                                   color: kPrimaryColor,
          //                                   fontSize: widthX * 0.038),
          //                             ),
          //                             GestureDetector(
          //                               onTap: (){
          //                                 favProvider.favServices.contains(index) ? favProvider.removeItem(index) : favProvider.addItem(index);
          //                               },
          //
          //                               child: Icon(
          //                                 vm.favServices.contains(index) ? services[index]['staticIcon2'] : services[index]['staticIcon'],
          //                                 size: heightX * 0.025,
          //                                 color: kPrimaryColor,
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
          //
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
