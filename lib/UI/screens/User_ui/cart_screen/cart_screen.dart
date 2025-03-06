import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../bottom_nav_bar/book_appointment/book_appointment.dart';
import '../bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import '../bottom_nav_bar/services/all_services/all_services.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('Cart',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: widthX * 0.063)),
      ),
      backgroundColor: kContainerColor,
      body: StreamBuilder(
        stream: cart.fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.shoppingCart,
                      height: heightX * 0.35,
                    ),
                    Text(
                      'Your Cart is empty',
                      style: primaryTextStyle.copyWith(
                          color: kPrimaryColor, fontSize: widthX * 0.085),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'You have no service in your shopping cart.\nLet\'s go and add a service',
                      style: smallTextStyle.copyWith(
                          color: kPrimaryColor,
                          fontSize: widthX * 0.042,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    CustomButton(
                      height: heightX * 0.06,
                      width: widthX * 0.7,
                      text: 'Add Service',
                      borderRadius: 10,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllServices()));
                      },
                      style: mediumTextStyle,
                      btnColor: kPrimaryColor,
                    )
                  ],
                ),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            print('Empty');
          }
          if (snapshot.data != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(widthX * 0.03),
                        child: Container(
                          height: heightX * 0.13,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widthX * 0.03,
                              right: widthX * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: heightX * 0.11,
                                  width: widthX * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              snapshot.data!.docs[index]
                                                  ['service_image_url']))),
                                ),
                                SizedBox(
                                  width: widthX * 0.47,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['service_name'],
                                        style: mediumTextStyle.copyWith(
                                            color: kPrimaryColor),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['service_price'].toString(),
                                        style: smallTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      cart.removeFromCart(
                                          snapshot.data!.docs[index].id, context);
                                      // cart.removeFromCart(
                                      //     snapshot.data![index]['docId']);
                                      //  cart.removeItem(
                                      //      cart.itemsList[index]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: kPrimaryColor,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomButton(
                      height: heightX * 0.06,
                      width: widthX * 0.9,
                      text: 'Next',
                      borderRadius: heightX * 0.013,
                      onPress: () {
                        List<String> serviceImageUrls = [];
                        List<String> serviceNames = [];
                        List<int> servicePrices = [];

                        for (var doc in snapshot.data!.docs) {
                          serviceImageUrls.add(doc['service_image_url']);
                          serviceNames.add(doc['service_name']);
                          servicePrices.add(doc['service_price']);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookAppointment(
                              serviceImageUrls: serviceImageUrls,
                              serviceNames: serviceNames,
                              servicePrices: servicePrices,
                              cart: true,
                              cartLength: snapshot.data!.docs.length,
                            ),
                          ),
                        );
                      },

                      style: mediumTextStyle.copyWith(
                          fontSize: heightX * 0.022),
                      btnColor: kPrimaryColor),
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),

    );
  }
}
