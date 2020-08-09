import 'package:flutter/cupertino.dart';

class AppImages {
  static Image appLogo1({double width, double height}) {
    return Image.asset(
      'lib/src/assets/images/Emptycart.png',
      width: width ?? null,
      height: height ?? null,
    );
  }

  static Image paymentStatus({String status, double width, double height}) {
    if (status == 'Success') {
      return Image.asset(
        'lib/src/assets/images/payment-success.png',
        width: width ?? null,
        height: height ?? null,
      );
    } else {
      return Image.asset(
        'lib/src/assets/images/payment-failed.png',
        width: width ?? null,
        height: height ?? null,
      );
    }
  }

  static Image appLogo2({double width, double height}) {
    return Image.asset(
      'lib/src/assets/images/logo.jpg',
      width: width ?? null,
      height: height ?? null,
      // fit:BoxFit.fill
    );
  }

  static Image productimage({double width, double height, String imageurl}) {
    return Image.network(
      imageurl,
      width: width ?? null,
      height: height ?? null,
      // fit:BoxFit.fill
    );
  }
}
