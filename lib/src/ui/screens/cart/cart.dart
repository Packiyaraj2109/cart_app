import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/models/common/product_details_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<ProductDetailsModel> arguments;
  CartScreen({this.arguments, Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  List<ProductDetailsModel> cartFullList;

  int quantity;
  double cartTotal = 0;
  double totalcartamount;

  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  void initState() {
    cartFullList = widget.arguments;
    _cartTotalAmount();
    super.initState();
  }

  _cartTotalAmount() {
    cartTotal = 0;
    for (int i = 0; i < cartFullList.length; i++) {
      double price = double.parse(cartFullList[i].price.substring(1));
      int quantity = cartFullList[i].count;
      cartTotal = cartTotal + (price * quantity);
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        appBar: _appbarBuild(context),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Column(
                    children: List.generate(
                      cartFullList.length,
                      (index) {
                        ProductDetailsModel productItem = cartFullList[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            AppImages.productimage(
                                height: 90,
                                width: 90,
                                imageurl: productItem.image),
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(productItem.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "${productItem.count}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3),
                                        TextSpan(
                                            text: "x",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                        TextSpan(
                                            text: " Rs.${productItem.price}",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline3),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    if (productItem.count > 1) {
                                      productItem.count = productItem.count - 1;
                                    } else {
                                      cartFullList.removeAt(index);
                                    }

                                    _cartTotalAmount();
                                  },
                                );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.iconbox2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              child: IconButton(
                                splashColor: AppColors.transparent,
                                highlightColor: AppColors.transparent,
                                icon: Icon(
                                  Icons.add,
                                  color: AppColors.iconbox,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      if (productItem.count >= 0) {
                                        productItem.count =
                                            productItem.count + 1;
                                      } else {
                                        print("zero");
                                      }
                                      _cartTotalAmount();
                                    },
                                  );
                                },
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.iconbox2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              child: IconButton(
                                splashColor: AppColors.transparent,
                                highlightColor: AppColors.transparent,
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: AppColors.iconbox,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cartFullList.removeAt(index);
                                    _cartTotalAmount();
                                  });
                                },
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.iconbox2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                color: AppColors.gridbackground,
              ),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total:",
                          style: Theme.of(context).textTheme.headline3),
                      Text("Rs.${cartTotal}",
                          style: Theme.of(context).primaryTextTheme.headline6),
                    ],
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      _showScaffold("Order Placed");
                    },
                    label: Text(AppTextConstants.Purchase,
                        style: Theme.of(context).textTheme.headline3),
                    icon: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.iconColor,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize _appbarBuild(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70.0),
      child: AppBar(
        backgroundColor: AppColors.appthemecolor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(bottom: 16, top: 16),
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
    );
  }

  _showScaffold(String message) {
    setState(() {
      cartFullList = null;
    });
    Navigator.of(context).pop();
    scaffoldkey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        action: SnackBarAction(
          label: AppTextConstants.Dismiss,
          textColor: Colors.blue,
          onPressed: () {
            scaffoldkey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
