
import 'package:cart_app/src/ui/screens/login/login.dart';
import 'package:cart_app/src/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
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
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      );
  }
}