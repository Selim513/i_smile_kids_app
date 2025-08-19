import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class AssetHelper {
  //-images assets helper
  static Image imageAsset({
    required String name,
    BoxFit? boxFit,
    double? width,
    double? height,
  }) {
    return Image.asset(
      'assets/images/$name.png',
      fit: boxFit,
      width: width,
      height: height,
    );
  }

  static AssetImage assetImage({required String name, BoxFit? boxFit}) {
    return AssetImage('assets/images/$name.png');
  }

  //-svg assets helper
  static SvgPicture svgAssets({required String name, double? height}) {
    return SvgPicture.asset('assets/icons/$name.svg', height: height);
  }
}
