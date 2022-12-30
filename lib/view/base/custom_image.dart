import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final String placeholder;
  CustomImage(
      {@required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeholder = "assets/image/placeholder.jpg"});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset("assets/image/placeholder.jpg",
          height: height, width: width, fit: fit),
      errorWidget: (context, url, error) =>
          Image.asset(placeholder, height: height, width: width, fit: fit),
    );
  }
}
