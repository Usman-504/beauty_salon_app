import 'package:beauty_salon/UI/screens/bottom_nav_bar/services/cart_provider.dart';
import 'package:beauty_salon/core/constants/const_colors.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';

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
      backgroundColor: kContainerColor,
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: widthX * 0.04, top: heightX * 0.05),
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
                Text('Cart',
                    style: secondaryTextStyle.copyWith(
                        color: kButtonColor, fontSize: heightX * 0.03)),
              ],
            ),
          ),
          cart.itemsList.isEmpty ? Text('data') :
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                       ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cart.itemsList.length,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                Padding(
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
                                                    image: AssetImage(cart
                                                        .itemsList[index]['image']))),
                                          ),
                                          Column(
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
                                ),
                              ],
                            );
                          },
                        ),
                  CustomButton(
                    height: heightX * 0.06,
                    width: widthX * 0.8,
                    text: 'Book Appointment',
                    onPress: () {},
                    borderRadius: heightX * 0.013,
                    style: mediumTextStyle.copyWith(fontSize: heightX * 0.022),
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
