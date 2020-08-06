import 'package:cart_app/src/assets/themes/theme.dart';
import 'package:cart_app/src/blocs/home/home_bloc.dart';
import 'package:cart_app/src/blocs/login/login_bloc.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:cart_app/src/ui/screens/cart/cart_screen.dart';
import 'package:cart_app/src/ui/screens/details/productdetails_screen.dart';
import 'package:cart_app/src/ui/screens/home/home_screen.dart';
import 'package:cart_app/src/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[ 
        BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
    ),
     BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(),
    ),
    // (BuildContext context) => HomeBloc(),
    ],
      child: MaterialApp(
        theme: lightTheme(),
        initialRoute: ScreenRoutes.SIGNIN,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenRoutes.SIGNIN:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (BuildContext context) => LoginBloc(),
            child: LoginScreen(),
          );
        },
      );
      break;
    case ScreenRoutes.HOMEPAGE:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return HomeScreen();
        },
      );
      break;
    case ScreenRoutes.ITEMDETAILS:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductDetailsScreen(arguments: settings.arguments);
        },
      );
      break;
    case ScreenRoutes.CART:
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
