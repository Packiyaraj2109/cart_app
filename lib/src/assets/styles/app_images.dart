import 'package:flutter/cupertino.dart';

class AppImages {
  static Image appLogo1({double width,double  height}) {
    return Image.asset(
      'lib/src/assets/images/Emptycart.png',
      width: width ?? null,
      height: height ?? null,
      // fit:BoxFit.fill
    );
  }

    static Image appLogo2({double width,double  height}) {
    return Image.asset(
      'lib/src/assets/images/logo.jpg',
      width: width ?? null,
      height: height ?? null,
      // fit:BoxFit.fill
    );
  }

  static Image productimage({double width,double  height,String imageurl}) {
    return Image.network(
      imageurl,
      width: width ?? null,
      height: height ?? null,
      // fit:BoxFit.fill
    );
  }
}
