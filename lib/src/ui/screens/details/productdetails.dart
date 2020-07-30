import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
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
                imageurl:
                    "http://www.pngall.com/wp-content/uploads/2016/04/Apple-Fruit-Free-PNG-Image.png"),
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Apple",
                    style: Theme.of(context).textTheme.headline6, maxLines: 1),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  child: Text(
                    "Apples promote heart health in several ways. They're high in soluble fiber, which helps lower cholesterol. They also have polyphenols, which are linked to lower blood pressure and stroke risk.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Rs.300.00",
                        style: Theme.of(context).primaryTextTheme.headline6),
                    FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text('Add To Cart',
                          style: Theme.of(context).textTheme.headline3),
                      icon: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: AppColors.iconColor,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      backgroundColor: Colors.white,
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
}
