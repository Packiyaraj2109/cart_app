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
        _homebloc.listen(homeBlocListener);
        _homebloc.add(HomeProductDisplayEvent());
      },
    );
    super.initState();
  }

  Future<void> homeBlocListener(HomeState state) async {
    if (state is SnackbarState) {
      _showScaffold(state.msg);
    }
  }

  // Future<void> loginBlocListener(LoginState state) async {
  // if (state is LoginValidateSuccessState) {
  //   Navigator.of(context).pop();
  //   Navigator.of(context).pushNamed(ScreenRoutes.HOMEPAGE);
  // } else if (state is LoginFailedFailedState) {
  // _scaffoldKey.currentState.removeCurrentSnackBar();
  // _showScaffold(state.msg);
  // }
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

  PreferredSize _appbarBuild() {
    return PreferredSize(
      preferredSize: Size.fromHeight(130.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appthemecolor,
        centerTitle: true,
        title: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => logout(),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.close,
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
                ),
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

  GridView buildGridView(listItem) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (9 / 10),
      children: List.generate(
        listItem.length,
        (index) {
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
                        top: 16,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: AppImages.productimage(
                              imageurl: productItem.image,
                            ),
                          ),
                          Expanded(
                            child: Column(
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
        },
      ),
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

  _favouriteAdd(ProductDetailsModel productItem) {
    setState(
      () {
        productItem.favourite = !(productItem.favourite);
      },
    );
  }

  _cartAdd(ProductDetailsModel productItem) async {
    _homebloc
        .add(CartProductAddEvent(AppTextConstants.ADDPRODUCT, productItem));
  }

  Future<void> logout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppTextConstants.Logout),
          content: Text(AppTextConstants.ExitMsg),
          actions: <Widget>[
            FlatButton(
              child: Text(
                AppTextConstants.Confirm,
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              onPressed: () {
                _homebloc.add(
                  CartProductClearEvent(),
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                    ScreenRoutes.SIGNIN, (route) => false);
              },
            ),
            FlatButton(
              child: Text(
                AppTextConstants.Cancel,
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _cartNavigator() async {
    await Navigator.of(context).pushNamed(ScreenRoutes.CART);
    _scaffoldKey.currentState.removeCurrentSnackBar();
  }

   _showScaffold(String message) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        // action: SnackBarAction(
        //   label: AppTextConstants.Dismiss,
        //   textColor: AppColors.appBackgroundColor,
        //   onPressed: () {
        //     _scaffoldKey.currentState.hideCurrentSnackBar();
        //   },
        // ),
      ),
    );
  }
}
