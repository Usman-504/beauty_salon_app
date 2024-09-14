import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.height,
    required this.imageUrl,
    this.child,
  });

  final double height;
  final String imageUrl;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage = imageUrl.startsWith('http') || imageUrl.startsWith('https');
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image:  isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl)),
      ),
      child: child,
    );
  }
}