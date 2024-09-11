import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.height,
    required this.imageUrl,
  });

  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: NetworkImage(imageUrl)),
      ),
    );
  }
}