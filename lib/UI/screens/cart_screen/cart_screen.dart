
import 'package:beauty_salon/UI/screens/cart_screen/cart_provider.dart';
import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/all_services/all_services.dart';
import 'package:beauty_salon/UI/screens/checkout/checkout_screen.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:beauty_salon/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';

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
        backgroundColor: kButtonColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            )),
        centerTitle: true,
        title: Text('Cart',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: heightX * 0.03)),
      ),
      backgroundColor: kContainerColor,
      body: Column(
        children: [
          cart.itemsList.isEmpty
              ? Center(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.shoppingCart, height: heightX * 0.35, ),
                      Text(
                        'Your Cart is empty',
                        style: primaryTextStyle.copyWith(
                            color: kButtonColor, fontSize: heightX * 0.04),
                      ),
                      Text(textAlign: TextAlign.center,
                        'You have no service in your shopping cart.\nLet\'s go and add a service',
                        style: smallTextStyle.copyWith(
                            color: kButtonColor,
                            fontSize: heightX * 0.02,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: heightX * 0.03,
                      ),

                      CustomButton(height: heightX * 0.06, width: widthX * 0.7, text: 'Add Service', borderRadius: 10, onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AllServices()));
                      }, style: mediumTextStyle)
                    ],
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cart.itemsList.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(widthX * 0.03),
                              child: Container(
                                height: heightX * 0.13,
                                decoration: BoxDecoration(
                                  color: kCircleAvatorColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: widthX * 0.03,
                                    right: widthX * 0.03,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: heightX * 0.11,
                                        width: widthX * 0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    cart.itemsList[index]
                                                        ['image']))),
                                      ),
                                      SizedBox(
                                        width: widthX * 0.47,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cart.itemsList[index]['title'],
                                              style: mediumTextStyle.copyWith(
                                                  color: kButtonColor),
                                            ),
                                            Text(
                                              cart.itemsList[index]['price'],
                                              style: smallTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            cart.removeItem(
                                                cart.itemsList[index]);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: kButtonColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        CustomButton(
                          height: heightX * 0.06,
                          width: widthX * 0.8,
                          text: 'Checkout',
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen()));
                          },
                          borderRadius: heightX * 0.013,
                          style: mediumTextStyle.copyWith(
                              fontSize: heightX * 0.022),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}