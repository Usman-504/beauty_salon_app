import 'package:beauty_salon/UI/components/header.dart';
import 'package:beauty_salon/UI/screens/stylists/stylists_details.dart';
import 'package:beauty_salon/UI/screens/stylists/stylists_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../components/custom_textfield.dart';
import '../../components/filter_icon.dart';

class AllStylists extends StatelessWidget {
  const AllStylists({super.key});


  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
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
                    child: Icon(
                      Icons.arrow_back,
                      size: heightX * 0.04,
                      color: kButtonColor,
                    )),
                SizedBox(
                  width: widthX * 0.03,
                ),
                Text('Stylists',
                    style: mediumTextStyle.copyWith(
                        color: kButtonColor, fontSize: heightX * 0.03)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(heightX * 0.02),
              child: GridView.builder(
                  itemCount: stylists.length,
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
                                builder: (context) => StylistsDetails(
                                    name: stylists[index]['name'],
                                    category: stylists[index]['category'],
                                    image: stylists[index]['image'], about: stylists[index]['about'],)));
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
                              height: heightX * 0.22,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage(stylists[index]['image'])),
                              ),
                            ),
                            // SizedBox(
                            //   height: heightX * 0.02,
                            // ),
                            // Text(
                            //   stylists[index]['category'],
                            //   style: smallTextStyle.copyWith(
                            //       fontSize: heightX * 0.02),
                            // ),
                            Container(
                              height: heightX * 0.039,
                              width: widthX * 0.5,
                              decoration: const BoxDecoration(
                                  color: kCircleAvatorColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8))),
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
    );
  }
}
