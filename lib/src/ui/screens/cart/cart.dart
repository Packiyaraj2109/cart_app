import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appthemecolor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                        size: 20.0,
                        color: AppColors.iconColor2,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                      color: AppColors.iconbox2,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        AppTextConstants.Cart,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
