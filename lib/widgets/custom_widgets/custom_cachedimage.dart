import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedimage extends StatelessWidget {
  final String imageUrl;
  int? memCacheHeight;
  double? height;
  final Widget placeHolderWidget;
  final Widget errorWidget;
  final Key valueKey;
  CustomCachedimage({
    super.key,
    required this.imageUrl,
    this.memCacheHeight,
    required this.height,
    required this.placeHolderWidget,
    required this.errorWidget,
    required this.valueKey,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      key: valueKey,
      memCacheHeight: memCacheHeight,
      height: height,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      fit: BoxFit.contain,
      placeholder: (context, url) => placeHolderWidget,
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
