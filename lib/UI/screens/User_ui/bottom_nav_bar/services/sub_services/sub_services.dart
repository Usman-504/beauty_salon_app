import 'package:beauty_salon/UI/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/constants/const_styles.dart';
import '../../../../../components/side_drawer.dart';
import '../../../favourite/fav_provider.dart';
import '../all_services/all_services.dart';
import '../services_details/service_details.dart';

class SubServices extends StatelessWidget {
  SubServices({required this.services, required this.text, super.key});

  List<Map<String, dynamic>> services = [];
  String text;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final favProvider = Provider.of<FavProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
         Header(scaffoldKey: _scaffoldKey,),
          Padding(
            padding: EdgeInsets.only(left: widthX * 0.04, top: heightX * 0.02),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AllServices()));
                    },
                    child:  Icon(
                      Icons.arrow_back,
                      size: heightX * 0.04,
                      color: kPrimaryColor,
                    )),
                SizedBox(
                  width: widthX * 0.03,
                ),
                Text(text,
                    style: mediumTextStyle.copyWith(
                        color: kPrimaryColor, fontSize: heightX * 0.03)),
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
                                          price: 'Rs. ${services[index]
                                          ['price']}/-', description: services[index]['description'],
                                          favIcon: services[index]
                                        ['staticIcon'], index: services[index],
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kContainerColor,
                                border: Border.all(color: kPrimaryColor, width: 2),
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
                                      fontSize: widthX * 0.042),
                                ),
                                Container(
                                  height: heightX * 0.035,
                                  decoration: const BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Rs. ${services[index]['price']}/-',
                                        style: smallTextStyle.copyWith(
                                            color: kPrimaryColor,
                                            fontSize: widthX * 0.038),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          favProvider.favServices.contains(index) ? favProvider.removeItem(index) : favProvider.addItem(index);
                                        },

                                        child: Icon(
                                          vm.favServices.contains(index) ? services[index]['staticIcon2'] : services[index]['staticIcon'],
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
          ),
        ],
      ),
    );
  }
}
