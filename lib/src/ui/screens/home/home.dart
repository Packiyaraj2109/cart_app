import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/data/repository/home/fruits_repository.dart';
import 'package:cart_app/src/data/repository/home/vegetable_repository.dart';
import 'package:cart_app/src/models/fruits/product_response_model.dart';
import 'package:cart_app/src/models/vegetables/vegetable_response_model.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static bool _isPressed = false;
  List<Fruits> productFruits = [];
  List<Vegetables> productVegetables = [];
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
          backgroundColor: AppColors.appthemecolor,
          appBar: _appbarBuild(context),
          body: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }

  PreferredSize _appbarBuild(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(110.0),
      child: AppBar(
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
                  onTap: () => Navigator.of(context).pushNamed("cart"),
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
                        top: 4,
                        right: 5.0,
                        child: Icon(Icons.brightness_1,
                            size: 14.0, color: Colors.black),
                      ),
                      Positioned(
                        top: 5.5,
                        right: 8.5,
                        child: new Text("3",
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold)),
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

  GridView vegetablesTabView() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (9 / 10),
      children: List.generate(
        productVegetables.length,
        (index) {
          Vegetables productItem = productVegetables[index];
          Map detailsArgument = {
            'image': productItem.image,
            'name': productItem.name,
            'description': productItem.decription,
            'price': productItem.price
          };
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  ScreenRoutes.ITEMDETAILS,
                  arguments: detailsArgument),
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: new Icon(
                          Icons.favorite_border,
                          color: (_isPressed) ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _isPressed = !_isPressed;
                            },
                          );
                        },
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Align(
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
      children: List.generate(
        productFruits.length,
        (index) {
          Fruits productItem = productFruits[index];
          Map detailsArgument = {
            'image': productItem.image,
            'name': productItem.name,
            'description': productItem.decription,
            'price': productItem.price
          };
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  ScreenRoutes.ITEMDETAILS,
                  arguments: detailsArgument),
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: new Icon(
                          Icons.favorite_border,
                          color: (_isPressed) ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _isPressed = !_isPressed;
                            },
                          );
                        },
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Align(
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

  TabBar _tabbar() {
    return TabBar(
      tabs: [
        Container(
          padding: EdgeInsets.only(bottom: 2),
          height: 50,
          alignment: Alignment.bottomLeft,
          child: Text(
            AppTextConstants.Fruits,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.only(bottom: 2),
          alignment: Alignment.bottomLeft,
          child: Text(
            AppTextConstants.Vegatables,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey[500],
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3.0,
          color: AppColors.borderColor,
        ),
        insets: EdgeInsets.only(right: 145, left: 16),
      ),
    );
  }
}
