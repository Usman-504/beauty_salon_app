import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/const_colors.dart';
import '../screens/User_ui/cart_screen/cart_provider.dart';
import '../screens/User_ui/cart_screen/cart_screen.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context);
    return Positioned(
      top: heightX * 0.15,
      left: widthX * 0.82,
      child: Container(
        height: heightX * 0.065,
        width: widthX * 0.14,
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(heightX * 0.016),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartScreen(
              )));
            },
              child: Center(
                child: Badge(
                  backgroundColor: kSecondaryColor,
                  label: Text(cart.itemsList.length.toString()),
                  child: const Icon(
                              Icons.shopping_cart_rounded,
                              color: kWhiteColor,
                            ),
                ),
              )),
        ),
      ),
    );
  }
}
