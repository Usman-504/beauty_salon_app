import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/user_view_model/cart_view_model.dart';
import '../../view/user_view/cart_view.dart';
import '../../res/colors.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
   // Provider.of<CartProvider>(context).getLength();
   final cart = Provider.of<CartProvider>(context);
    return Positioned(
      top: heightX * 0.15,
      left: widthX * 0.82,
      child: Container(
        height: heightX * 0.065,
        width: widthX * 0.14,
        decoration: BoxDecoration(
            color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(heightX * 0.016),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartScreen(
              )));
            },
              child: Center(
                child: Badge(
                  backgroundColor: AppColors.secondaryColor,
                  label: Text(cart.cartLength.toString()),
                  child: const Icon(
                              Icons.shopping_cart_rounded,
                              color: AppColors.whiteColor,
                            ),
                ),
              )),
        ),
      ),
    );
  }
}
