import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  const CustomNetworkImage({super.key, required this.imageUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width ,
      imageUrl: imageUrl,
      color: Colors.transparent,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        height: height,
        width: width,
        color: Colors.grey,
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        color: Colors.grey,
        child: Icon(Icons.error),
      ),
    );
  }
}
