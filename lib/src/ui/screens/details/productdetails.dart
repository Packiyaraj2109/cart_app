import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/models/common/product_details_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsModel arguments;
  ProductDetailsScreen({this.arguments, Key key}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsModel productdetails;
  @override
  void initState() {
    productdetails = widget.arguments;
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appthemecolor,
        appBar: _appbarBuild(context),
        body: _bodyBuild(),
      ),
    );
  }

  Container _bodyBuild() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: AppImages.productimage(
                width: double.maxFinite,
                height: double.maxFinite,
                imageurl: productdetails.image),
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(productdetails.name,
                    style: Theme.of(context).textTheme.headline6, maxLines: 1),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  child: Text(
                    productdetails.decription,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Divider(
                  color: AppColors.dividercolor,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(productdetails.price,
                        style: Theme.of(context).primaryTextTheme.headline6),
                    FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text(AppTextConstants.Addtocart,
                          style: Theme.of(context).textTheme.headline3),
                      icon: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: AppColors.iconColor,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.iconbox,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      backgroundColor: AppColors.gridbackground,
                      elevation: 0,
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              color: AppColors.gridbackground,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appbarBuild(BuildContext context) {
    return AppBar(
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
                  onPressed: () => _cartExit(),
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
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
                    AppTextConstants.Products,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _cartExit() {
    Navigator.of(context).pop();
  }
}
