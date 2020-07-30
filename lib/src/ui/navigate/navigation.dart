
import 'package:cart_app/src/assets/themes/theme.dart';
import 'package:cart_app/src/ui/screens/cart/cart.dart';
import 'package:cart_app/src/ui/screens/details/productdetails.dart';
import 'package:cart_app/src/ui/screens/home/home.dart';
import 'package:cart_app/src/ui/screens/login/login.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(),
      initialRoute: 'home',
      onGenerateRoute:generateRoute
    );
  }
}



  Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'login':
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      );
      break;
    case 'home':
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return HomeScreen();
        },
      );
      break;
    case 'details':
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductDetails();
        },
      );
      break;
    case 'cart':
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return CartScreen();
        },
      );
      break;
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      );
  }
}