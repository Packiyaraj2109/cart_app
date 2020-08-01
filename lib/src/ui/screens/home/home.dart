import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/data/repository/home/fruits_repository.dart';
import 'package:cart_app/src/data/repository/home/vegetable_repository.dart';
import 'package:cart_app/src/models/common/product_details_model.dart';
import 'package:cart_app/src/models/fruits/product_response_model.dart';
import 'package:cart_app/src/models/vegetables/vegetable_response_model.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ProductDetailsModel> productFruits = [];
  List<ProductDetailsModel> cartitems = [];
  List<ProductDetailsModel> productVegetables = [];

  @override
  void initState() {
    datafetch();
    super.initState();
  }

  Future<void> datafetch() async {
    FruitResponseModel fruitResponse = await FruitRepository().fetchproducts();
    VegetabeResponseModel vegetableResponse =
        await VegetableRepository().fetchproducts();
    setState(
      () {
        productFruits = fruitResponse.fruits;
        productVegetables = vegetableResponse.vegetables;
      },
    );
  }

  Widget build(BuildContext context) {
    List<Widget> containers = [fruitsTabView(), vegetablesTabView()];
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.appthemecolor,
          appBar: _appbarBuild(context),
          body: _bodyBuild(containers),
        ),
      ),
    );
  }

  TabBarView _bodyBuild(List<Widget> containers) {
    return TabBarView(
      children: containers,
    );
  }

  PreferredSize _appbarBuild(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(130.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appthemecolor,
        centerTitle: true,
        title: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 16),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      AppTextConstants.Home,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _cartNavigator,
                  child: Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20.0,
                          color: AppColors.iconColor2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          color: AppColors.iconbox2,
                        ),
                      ),
                      Positioned(
                        right: 4,
                        top: 5,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.notification),
                          alignment: Alignment.center,
                          child: Text(
                            '${cartitems.length}',
                            style: TextStyle(
                                fontSize: 8, color: AppColors.gridbackground),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottom: _tabbar(),
        elevation: 0.0,
      ),
    );
  }

  void _cartNavigator() async {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    await Navigator.of(context)
        .pushNamed(ScreenRoutes.CART, arguments: cartitems);
    setState(
      () {},
    );
  }

  GridView vegetablesTabView() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (9 / 10),
      children: List.generate(
        productVegetables.length,
        (index) {
          ProductDetailsModel productItem = productVegetables[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(ScreenRoutes.ITEMDETAILS, arguments: productItem),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  color: AppColors.gridbackground,
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 25,
                        bottom: 8,
                        left: 25,
                        right: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppImages.productimage(
                            width: 120,
                            height: 100,
                            imageurl: productItem.image,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                productItem.name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              SizedBox(height: 4),
                              Text(
                                productItem.price,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      child: IconButton(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        icon: new Icon(
                          Icons.favorite_border,
                          color: (productItem.favourite)
                              ? AppColors.borderColor
                              : AppColors.themeColor,
                        ),
                        onPressed: () => _favouriteAdd(productItem),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Align(
                      child: GestureDetector(
                        onTap: () => _cartAdd(productItem),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.shop,
                            size: 20.0,
                            color: AppColors.iconColor,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                            color: AppColors.iconbox,
                          ),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  GridView fruitsTabView() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (9 / 10),
      children: List.generate(productFruits.length, (index) {
        ProductDetailsModel productItem = productFruits[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(ScreenRoutes.ITEMDETAILS, arguments: productItem),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: AppColors.gridbackground,
              ),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 25,
                      bottom: 8,
                      left: 25,
                      right: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppImages.productimage(
                          width: 120,
                          height: 100,
                          imageurl: productItem.image,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              productItem.name,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(height: 4),
                            Text(
                              productItem.price,
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    child: IconButton(
                      splashColor: AppColors.transparent,
                      highlightColor: AppColors.transparent,
                      icon: new Icon(
                        Icons.favorite_border,
                        color: (productItem.favourite)
                            ? AppColors.borderColor
                            : AppColors.themeColor,
                      ),
                      onPressed: () => _favouriteAdd(productItem),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  Align(
                    child: GestureDetector(
                      onTap: () => _cartAdd(productItem),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.shop,
                          size: 20.0,
                          color: AppColors.iconColor,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          color: AppColors.iconbox,
                        ),
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _favouriteAdd(ProductDetailsModel productItem) {
    setState(
      () {
        productItem.favourite = !(productItem.favourite);
      },
    );
  }

  _cartAdd(ProductDetailsModel productItem) {
    int index = cartitems.indexWhere((element) =>
        element.id == productItem.id && element.name == productItem.name);

    if (index != -1) {
      cartitems[index].count = cartitems[index].count + 1;
      _showScaffold(
          '${productItem.name} is already available in cart. Quantity: ${productItem.count}');
    } else {
      productItem.count = 1;
      cartitems.add(productItem);
      _showScaffold('${productItem.name} is added to cart');
    }
    setState(
      () {
        cartitems = cartitems;
      },
    );
  }

  TabBar _tabbar() {
    return TabBar(
      tabs: [
        Container(
          padding: EdgeInsets.only(bottom: 12),
          height: 50,
          alignment: Alignment.bottomLeft,
          child: Text(
            AppTextConstants.Fruits,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.only(bottom: 12),
          alignment: Alignment.bottomLeft,
          child: Text(
            AppTextConstants.Vegatables,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
      labelColor: AppColors.tabselected,
      unselectedLabelColor: AppColors.tabunselected,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3.0,
          color: AppColors.borderColor,
        ),
        insets: EdgeInsets.only(right: 145, left: 16, bottom: 8),
      ),
    );
  }

  _showScaffold(String message) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        action: SnackBarAction(
          label: AppTextConstants.Dismiss,
          textColor: AppColors.appBackgroundColor,
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
