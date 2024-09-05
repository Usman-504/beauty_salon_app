import 'package:beauty_salon/UI/components/custom_button.dart';
import 'package:beauty_salon/UI/components/white_container.dart';
import 'package:beauty_salon/core/constants/const_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/const_colors.dart';
import '../../../../../components/image_container.dart';
import '../../../cart_screen/cart_screen.dart';
import '../../book_appointment/book_appointment.dart';
import '../../../cart_screen/cart_provider.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails(
      {required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.favIcon,
      required this.index,
      super.key});

  final String imageUrl;
  final String title;
  final String price;
  final String description;
  final IconData favIcon;
  final Map index;

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    void showSnackBar(String message, Function() onPress, String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: smallTextStyle,
          ),
          action: SnackBarAction(
            label: text,
            onPressed: onPress,
            textColor: kPrimaryColor,
          ),
          backgroundColor: kSecondaryColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: kContainerColor,
      body: Stack(
        children: [
          Container(
            height: heightX * 1,
          ),
          ImageContainer(
            height: heightX * 0.6,
            imageUrl: imageUrl,
          ),
          Positioned(
              top: heightX * 0.05,
              left: widthX * 0.03,
              child: Container(
                  height: heightX * 0.047,
                  width: widthX * 0.1,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(heightX * 0.03)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                      )))),
          Positioned(
            left: widthX * 0.05,
            top: heightX * 0.5,
            child: WhiteContainer(
              height: heightX * 0.45,
              width: widthX * 0.9,
              child: Padding(
                padding:
                    EdgeInsets.only(left: widthX * 0.05, right: widthX * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: mediumTextStyle.copyWith(
                              color: kPrimaryColor, fontSize: widthX * 0.063),
                        ),
                        Icon(
                          favIcon,
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                    Text(
                      price,
                      style: smallTextStyle.copyWith(color: kSecondaryColor),
                    ),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: description,
                        style: smallTextStyle.copyWith(
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: heightX * 0.03,
                    ),
                    Consumer<CartProvider>(
                      builder: (context, vm, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              height: heightX * 0.06,
                              width: widthX * 0.38,
                              text: 'Book Now',
                              onPress: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookAppointment(serviceIndex: index,)));
                              },
                              borderRadius: heightX * 0.013,
                              style: mediumTextStyle.copyWith(
                                  fontSize: heightX * 0.022), btnColor: kPrimaryColor,
                            ),
                            CustomButton(
                              height: heightX * 0.06,
                              width: widthX * 0.38,
                              text: cartProvider.itemsList.contains(index)
                                  ? 'Added To Cart'
                                  : 'Add To Cart',
                              onPress: () {
                                if (cartProvider.itemsList.contains(index)) {
                                  showSnackBar('Service already in Cart', () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CartScreen()));
                                  }, 'View Cart');
                                } else {
                                  cartProvider.addItem(index);
                                  showSnackBar('Service added to Cart', () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CartScreen()));
                                  }, 'View Cart');
                                }
                              },
                              borderRadius: heightX * 0.013,
                              style: mediumTextStyle.copyWith(
                                  fontSize: heightX * 0.022), btnColor: kPrimaryColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
