import 'package:beauty_salon/UI/components/header.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/service_details.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/services_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../components/filter_icon.dart';
import 'fav_provider.dart';

class SubServices extends StatelessWidget {
  SubServices({required this.services, required this.text, super.key});

  List<Map<String, dynamic>> services = [];
  String text;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final favProvider = Provider.of<FavProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
         Header(),
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
                      color: kButtonColor,
                    )),
                SizedBox(
                  width: widthX * 0.03,
                ),
                Text(text,
                    style: mediumTextStyle.copyWith(
                        color: kButtonColor, fontSize: heightX * 0.03)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(heightX * 0.02),
              child: Consumer<FavProvider>(
                builder: (context, vm, child) {
                  return GridView.builder(
                      itemCount: services.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.5,
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
                                          title: services[index]
                                          ['title'],
                                          imageUrl: services[index]
                                          ['image'],
                                          price: services[index]
                                          ['price'], description: services[index]['description'],
                                          favIcon: services[index]
                                        ['staticIcon'], index: services[index],
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kContainerColor,
                                border: Border.all(color: kButtonColor, width: 2),
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
                                        AssetImage(services[index]['image'])),
                                  ),
                                ),
                                // SizedBox(
                                //   height: heightX * 0.02,
                                // ),
                                Text(
                                  services[index]['title'],
                                  style: smallTextStyle.copyWith(
                                      fontSize: heightX * 0.02),
                                ),
                                Container(
                                  height: heightX * 0.035,
                                  decoration: const BoxDecoration(
                                      color: kCircleAvatorColor,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        services[index]['price'],
                                        style: smallTextStyle.copyWith(
                                            color: kButtonColor,
                                            fontSize: heightX * 0.018),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          favProvider.favItems.contains(index) ? favProvider.removeItem(index) : favProvider.addItem(index);
                                        },

                                        child: Icon(
                                          vm.favItems.contains(index) ? services[index]['staticIcon2'] : services[index]['staticIcon'],
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
        ],
      ),
    );
  }
}
