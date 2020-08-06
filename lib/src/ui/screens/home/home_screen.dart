import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/blocs/home/home_bloc.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/models/common/product_details_model.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ProductDetailsModel> cartitems = [];

  HomeBloc _homebloc;
  String msg;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _homebloc = BlocProvider.of<HomeBloc>(context);
        // _homebloc.listen(loginBlocListener);
        _homebloc.add(HomeProductDisplayEvent());
      },
    );
    super.initState();
  }

  // Future<void> loginBlocListener(HomeState state) async {
  //   if (state is ItemDisplayState) {
  //     productFruits = state.productList;
  //   }
  // }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.appthemecolor,
          appBar: _appbarBuild(),
          body: _bodyBuild(),
        ),
      ),
    );
  }

  Widget _bodyBuild() {
    return BlocBuilder<HomeBloc, HomeState>(
      condition: (HomeState previous, HomeState current) {
        return current is ItemDisplayState;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is ItemDisplayState &&
            state.productListFruits.isNotEmpty &&
            state.productListVegetables.isNotEmpty) {
          List<Widget> containers = [
            buildGridView(state.productListFruits),
            buildGridView(state.productListVegetables)
          ];
          return TabBarView(
            children: containers,
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(AppColors.appBackgroundColor),
          ),
        );
      },
    );
  }

  PreferredSize _appbarBuild() {
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
                  child: BlocBuilder<HomeBloc, HomeState>(
                    condition: (previous, current) => current is AddToCartState,
                    builder: (context, state) {
                      String count = '0';
                      if (state is AddToCartState) {
                        count = state.cartitems.length.toString();
                      }
                      return Stack(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.notification),
                              alignment: Alignment.center,
                              child: Text(
                                count,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: AppColors.gridbackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
    await Navigator.of(context).pushNamed(ScreenRoutes.CART);
    setState(
      () {
        cartitems.length;
      },
    );
  }

  GridView buildGridView(listItem) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (9 / 10),
      children: List.generate(listItem.length, (index) {
        ProductDetailsModel productItem = listItem[index];
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
                          Icons.add_shopping_cart,
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
    _homebloc.add(CartProductAddEvent(AppTextConstants.ADDPRODUCT, productItem));
    _showScaffold(
        "${productItem.name} Added to cart. Quantity: ${productItem.count}");

    // setState(
    //   () {
    //     cartitems = cartitems;
    //   },
    // );
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