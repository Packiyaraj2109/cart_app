import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/config/app_config.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final Map arguments;
  TransactionScreen({this.arguments, Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Map arguments;
  String response;

  @override
  void initState() {
    arguments = widget.arguments;
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _homeScreen(),
      child: SafeArea(
        child: Scaffold(
          body: _bodybuild(context),
        ),
      ),
    );
  }

  Container _bodybuild(BuildContext context) {
    String status;
    String response;
    if (arguments['error'] == null) {
      status='Success';
      response = arguments['status'];
    } else {
      status = 'Failed';
      response = arguments['error'];
    }
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppImages.paymentStatus(status: status, width: 150, height: 150),
            SizedBox(height: 30),
            Text("${response}",
                style: Theme.of(context).accentTextTheme.headline5),
            SizedBox(height: 100),
            Container(
              height: 50,
              width: 140,
              child: RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
                ),
                color: AppColors.appBackgroundColor,
                onPressed: () => _homeScreen(),
                // _placeOrder(cartFullList),
                child: Text(AppTextConstants.BACK,
                    style: Theme.of(context).accentTextTheme.headline6),
              ),
            ),
          ],
        ),
      ),
    );
  }

 _homeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(ScreenRoutes.HOMEPAGE, (route) => false);
  }
}


