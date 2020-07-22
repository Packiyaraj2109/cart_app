import 'package:cart_app/ui/login/login.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'init',
      onGenerateRoute: generateRoute,
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
   
      case 'todoview':
      return MaterialPageRoute( 
        builder: (BuildContext context) {
          return LoginScreen();
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
