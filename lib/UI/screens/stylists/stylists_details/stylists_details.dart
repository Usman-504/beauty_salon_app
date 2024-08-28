// import 'package:beauty_salon/UI/components/custom_button.dart';
// import 'package:beauty_salon/UI/components/image_container.dart';
// import 'package:beauty_salon/UI/components/white_container.dart';
// import 'package:beauty_salon/core/constants/const_styles.dart';
// import 'package:flutter/material.dart';
// import '../../../../../core/constants/const_colors.dart';
// import '../../bottom_nav_bar/book_appointment/book_appointment.dart';
//
// class StylistsDetails extends StatelessWidget {
//   const StylistsDetails(
//       {required this.name,
//         required this.image,
//         required this.category,
//         required this.about,
//         super.key});
//
//  final String image;
//  final String name;
//  final String category;
//  final String about;
//
//   @override
//   Widget build(BuildContext context) {
//     var heightX = MediaQuery.of(context).size.height;
//     var widthX = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: kContainerColor,
//       body: Stack(
//         children: [
//           Container(
//             height: heightX * 1,
//           ),
//           ImageContainer(
//             height: heightX * 0.6,
//             imageUrl: image,
//           ),
//           Positioned(
//               top: heightX * 0.05,
//               left: widthX * 0.03,
//               child: Container(
//                   height: heightX * 0.047,
//                   width: widthX * 0.1,
//                   decoration: BoxDecoration(
//                       color: kWhiteColor,
//                       borderRadius: BorderRadius.circular(heightX * 0.03)),
//                   child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Icon(
//                         Icons.arrow_back,
//                         color: kButtonColor,
//                       )))),
//           Positioned(
//             left: widthX * 0.05,
//             top: heightX * 0.5,
//             child: WhiteContainer(
//               height: heightX * 0.45,
//               width: widthX * 0.9,
//               child: Padding(
//                 padding:  EdgeInsets.only(left: widthX * 0.05, right:  widthX * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: heightX * 0.03,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           name,
//                           style: mediumTextStyle.copyWith(
//                               color: kButtonColor, fontSize: heightX * 0.03),
//                         ),
//                         const Icon(Icons.favorite_border, color: kButtonColor,)
//                       ],
//                     ),
//                     SizedBox(
//                       height: heightX * 0.03,
//                     ),
//                     //Text(category, style: smallTextStyle.copyWith(color: kCircleAvatorColor),),
//
//                     RichText(
//                       textAlign: TextAlign.justify,
//                       text: TextSpan(text: about, style: smallTextStyle.copyWith( fontWeight: FontWeight.normal),),),
//                     SizedBox(
//                       height: heightX * 0.03,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomButton(height: heightX * 0.06, width: widthX * 0.8, text: 'Book Appointment', onPress: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAppointment()));
//                         }, borderRadius: heightX * 0.013, style: mediumTextStyle.copyWith(fontSize: heightX* 0.022),),
//
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

















// import 'package:beauty_salon/UI/components/white_container.dart';
// import 'package:beauty_salon/core/constants/const_colors.dart';
// import 'package:beauty_salon/core/constants/const_styles.dart';
// import 'package:flutter/material.dart';
//
// class StylistsDetails extends StatelessWidget {
//   StylistsDetails(
//       {required this.name,
//       required this.category,
//       required this.image,
//       super.key});
//
//   // List<Map<String, dynamic>> stylistsDetails = [];
//   String name;
//   String category;
//   String image;
//
//
//   @override
//   Widget build(BuildContext context) {
//     var heightX = MediaQuery.of(context).size.height;
//     var widthX = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       body: Column(
//         children: [
//           // Stack(
//           //   children: [
//           //     Container(
//           //       height: heightX * 0.45,
//           //       width: widthX * 1,
//           //       color: kContainerColor,
//           //     ),
//           //     Positioned(
//           //         top: heightX * 0.08,
//           //         left: widthX * 0.03,
//           //         child: GestureDetector(
//           //             onTap: (){
//           //               Navigator.pop(context);
//           //             },
//           //             child: const Icon(Icons.arrow_back_ios_rounded))),
//           //     Positioned(
//           //       top: heightX * 0.23,
//           //       left: widthX * 0.04,
//           //       child: Text(
//           //         name,
//           //         style: secondaryTextStyle.copyWith(
//           //             color: kButtonColor, fontSize: heightX * 0.035),
//           //       ),
//           //     ),
//           //     Positioned(
//           //       top: heightX * 0.27,
//           //       left: widthX * 0.04,
//           //       child: Text(
//           //         category,
//           //         style: mediumTextStyle.copyWith(
//           //             color: kCircleAvatorColor, fontSize: heightX * 0.02),
//           //       ),
//           //     ),
//           //     Positioned(
//           //       top: heightX * 0.29,
//           //       left: widthX * 0.04,
//           //       child: Row(
//           //         children: [
//           //           Text(
//           //             '4.8',
//           //             style: secondaryTextStyle.copyWith(color: kButtonColor),
//           //           ),
//           //           Icon(
//           //             Icons.star,
//           //             color: kCircleAvatorColor,
//           //             size: heightX * 0.025,
//           //           ),
//           //           Icon(
//           //             Icons.star,
//           //             color: kCircleAvatorColor,
//           //             size: heightX * 0.025,
//           //           ),
//           //           Icon(
//           //             Icons.star,
//           //             color: kCircleAvatorColor,
//           //             size: heightX * 0.025,
//           //           ),
//           //           Icon(
//           //             Icons.star,
//           //             color: kCircleAvatorColor,
//           //             size: heightX * 0.025,
//           //           ),
//           //           Icon(
//           //             Icons.star_half,
//           //             color: kCircleAvatorColor,
//           //             size: heightX * 0.025,
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //     Positioned(
//           //         left: widthX * 0.37,
//           //         top: heightX * 0.07,
//           //         child: Image.asset(
//           //           image,
//           //           height: heightX * 0.38,
//           //         )),
//           //   ],
//           // ),
//
//         ],
//       ),
//     );
//   }
// }
