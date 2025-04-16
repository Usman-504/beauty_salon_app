import 'package:beauty_salon/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/image_container.dart';
import '../../res/components/white_container.dart';
import 'book_appointment_view.dart';
import '../../view_model/user_view_model/cart_view_model.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails(
      {required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.catId,
      required this.docId,


      super.key});

  final String imageUrl;
  final String title;
  final int price;
  final String description;
  final String catId;
  final String docId;

  //final Map index;

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
            textColor: AppColors.primaryColor,
          ),
          backgroundColor: AppColors.secondaryColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.containerColor,
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
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(heightX * 0.03)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
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
                              color: AppColors.primaryColor, fontSize: widthX * 0.063),
                        ),

                      ],
                    ),
                    Text(
                      'Rs. ${price.toString()}/-',
                     // price.toString(),
                      style: smallTextStyle.copyWith(color: AppColors.secondaryColor),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookAppointment(serviceName: title, servicePrice: price, serviceImageUrl: imageUrl,)));
                              },
                              borderRadius: heightX * 0.013,
                              style: mediumTextStyle.copyWith(
                                  fontSize: heightX * 0.022), btnColor: AppColors.primaryColor,
                            ),
                            CustomButton(
                              height: heightX * 0.06,
                              width: widthX * 0.38,
                              text:

                              // cartProvider.itemsList.contains(index)
                              //     ? 'Added To Cart':
                                   'Add To Cart',
                              onPress: () {
                                 vm.addToCart( title, price.toString(), imageUrl, context );
                                // if (cartProvider.itemsList.contains(index)) {
                                //   showSnackBar('Service already in Cart', () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const CartScreen()));
                                //   }, 'View Cart');
                                // }
                                // else {
                                //   cartProvider.addItem(index);
                                //   showSnackBar('Service added to Cart', () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const CartScreen()));
                                //   }, 'View Cart');
                                // }
                              },
                              borderRadius: heightX * 0.013,
                              style: mediumTextStyle.copyWith(
                                  fontSize: heightX * 0.022), btnColor: AppColors.primaryColor,
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
