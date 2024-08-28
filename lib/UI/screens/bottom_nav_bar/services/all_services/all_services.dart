import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/services_list/services_list.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/sub_services/sub_services.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../components/filter_icon.dart';
import '../../../../components/header.dart';
import '../../bottom_nav_screen/bottom_nav_bar.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Header(),
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
                      color: kButtonColor,
                    )),
                SizedBox(
                  width: widthX * 0.03,
                ),
                Text('All Services',
                    style: secondaryTextStyle.copyWith(
                        color: kButtonColor, fontSize: heightX * 0.03)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(heightX * 0.02),
              child: GridView.builder(
                  itemCount: serviceCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SubServices(services: serviceCategories[index]['services'], text: serviceCategories[index]['title'],)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            border: Border.all(color: kButtonColor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              serviceCategories[index]['image'],
                              height: heightX * 0.11,
                              color: kButtonColor,
                            ),
                            SizedBox(
                              height: heightX * 0.02,
                            ),
                            Text(
                              serviceCategories[index]['title'],
                              style: mediumTextStyle.copyWith(
                                  fontSize: heightX * 0.025, color: kButtonColor),
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


