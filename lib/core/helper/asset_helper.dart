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

  static Image gifAsset({
    required String name,
    BoxFit? boxFit,
    double? width,
    double? height,
    Key? key,
  }) {
    return Image.asset(
      key: key,
      'assets/gif/$name.gif',
      fit: boxFit,
      width: width,
      height: height,
    );
  }

  static AssetImage assetImage({required String name, BoxFit? boxFit}) {
    return AssetImage('assets/images/$name.png');
  }

  static AssetImage fetchGiftAsset({required String name, BoxFit? boxFit}) {
    return AssetImage('assets/gif/$name.gif');
  }

  //-svg assets helper
  static SvgPicture svgAssets({required String name, double? height}) {
    return SvgPicture.asset('assets/icons/$name.svg', height: height);
  }
}
