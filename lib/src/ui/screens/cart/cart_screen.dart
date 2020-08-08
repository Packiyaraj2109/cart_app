import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/blocs/home/home_bloc.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/models/common/product_details_model.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upi_india/upi_india.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  List<ProductDetailsModel> cartFullList = [];

  int quantity;
  double cartTotal = 0;
  double totalcartamount = 0;
  HomeBloc _homebloc;

  Future<UpiResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _homebloc = BlocProvider.of<HomeBloc>(context);
      },
    );
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbarBuild(),
        body: _bodyBuild(),
      ),
    );
  }

  Widget _bodyBuild() {
    return BlocBuilder<HomeBloc, HomeState>(
      condition: (HomeState previous, HomeState current) {
        return current is AddToCartState;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is AddToCartState && state.cartitems.isNotEmpty) {
          List<ProductDetailsModel> cartFullList = state.cartitems;
          return _bodyWidgets(cartFullList, context);
        }
        return _emptyCartBuild(context);
      },
    );
  }

  Container _emptyCartBuild(BuildContext context) {
    return Container(
      child: Opacity(
        opacity: .8,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppImages.appLogo1(
                height: 250,
                width: 250,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.appBackgroundColor, width: 2)),
                height: 40,
                width: 120,
                child: RaisedButton(
                    color: AppColors.appthemecolor,
                    onPressed: () => _goBack(),
                    child: Text(
                      "Shop Now",
                      style: Theme.of(context).primaryTextTheme.headline2,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _bodyWidgets(
      List<ProductDetailsModel> cartFullList, BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                right: 8,
                left: 8,
                bottom: 8,
              ),
              child: Column(
                children: List.generate(
                  cartFullList.length,
                  (index) {
                    ProductDetailsModel productItem = cartFullList[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: Container(
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   new BoxShadow(
                          //     color: Colors.grey[400],
                          //     blurRadius: 2.0,
                          //   ),
                          // ],
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(10),
                          ),
                          // border: Border(
                          //   bottom: BorderSide(
                          //       width: 0.5,
                          //       color: Theme.of(context).dividerColor),
                          // ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8, left: 8),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                    ScreenRoutes.ITEMDETAILS,
                                    arguments: productItem),
                                child: AppImages.productimage(
                                  height: 70,
                                  width: 70,
                                  imageurl: productItem.image,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      productItem.name,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    SizedBox(height: 5),
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "${productItem.count}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          TextSpan(
                                            text: "x",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          TextSpan(
                                            text: " ${productItem.price}",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _itemReduce(productItem,
                                    AppTextConstants.REDUCEPRODUCT);
                              },
                              child: Container(
                                // padding: EdgeInsets.only(left: 24),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              splashColor: AppColors.transparent,
                              highlightColor: AppColors.transparent,
                              icon: Icon(
                                Icons.add,
                                color: AppColors.iconbox,
                                size: 18,
                              ),
                              onPressed: () {
                                // _itemIncrease(cartFullList[index]);
                                _itemReduce(
                                    productItem, AppTextConstants.ADDPRODUCT);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: IconButton(
                                splashColor: AppColors.transparent,
                                highlightColor: AppColors.transparent,
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: AppColors.iconbox,
                                  size: 18,
                                ),
                                onPressed: () =>
                                    _itemDelete(productItem, 'delete'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            24,
            16,
            24,
            16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                16,
              ),
              topLeft: Radius.circular(
                16,
              ),
            ),
            color: AppColors.gridbackground,
          ),
          width: double.infinity,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Total:",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    TextSpan(
                      text: " ₹${_cartTotalAmount(cartFullList)}",
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 140,
                child: RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      40.0,
                    ),
                  ),
                  color: AppColors.appBackgroundColor,
                  onPressed: () => _modalBottomSheetMenu(),
                  // _placeOrder(cartFullList),
                  child: Text(AppTextConstants.Purchase,
                      style: Theme.of(context).accentTextTheme.headline6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _cartTotalAmount(List<ProductDetailsModel> cartFullList) {
    String totalPrice = cartFullList
        .fold(0, (a, b) => a + (b.count * double.parse(b.price.substring(1))))
        .toStringAsFixed(2);
    return totalPrice;
  }

  void _itemReduce(
      ProductDetailsModel productItem,
      /*List<ProductDetailsModel> cartFullList,*/ String action) {
    _homebloc.add(
      CartProductAddEvent(action, productItem),
    );
  }

  void _itemDelete(ProductDetailsModel productItem, String action) {
    _homebloc.add(
      CartProductAddEvent(action, productItem),
    );
  }

  _placeOrder(List<ProductDetailsModel> cartFullList) {
    // cartFullList.clear();
    // _showScaffold("Order Placed Sucessfully!!!");
    // Navigator.of(context).pop();
  }

  PreferredSize _appbarBuild() {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        70.0,
      ),
      child: AppBar(
        backgroundColor: AppColors.appthemecolor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(
            bottom: 16,
            top: 16,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 38,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    onPressed: () => _goBack(),
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

  // Future<void> _checkoutButtonPressed(String total) async {

  //   UpiTransactionResponse txnResponse = await UpiPay.initiateTransaction(
  //     amount: '1',
  //     app: UpiApplication.amazonPay,
  //     receiverName: 'Packiyaraj',
  //     receiverUpiAddress: '7502714189@apl',
  //     transactionRef: '12345678',
  //     merchantCode: '',
  //   );
  //   print("dsfdsf");

  // }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (builder) {
        if (apps == null)
          return Center(child: CircularProgressIndicator());
        else if (apps.length == 0)
          return Center(child: Text("No apps available for transaction."));
        else
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Wrap(
                children: apps.map<Widget>(
                  (UpiApp app) {
                    return GestureDetector(
                      onTap: () {
                        _transaction = initiateTransaction(app.app);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.memory(
                              app.icon,
                              height: 60,
                              width: 60,
                            ),
                            Text(app.name),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              
            ),
          );
      },
    );
  }

  Future<void> initiateTransaction(String app) async {
    UpiResponse txnResponse = await UpiIndia().startTransaction(
      app: app,
      receiverUpiId: '7502714189@apl',
      receiverName: 'Packiyaraj',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
      merchantId: "123456",
    );
    _homebloc.add(
      CartProductClearEvent(),
    );
    Navigator.of(context).pushNamed(ScreenRoutes.Payment,
        arguments: {'error': txnResponse.error, 'status': txnResponse.status});
  }

  _goBack() {
    Navigator.of(context).pop();
  }
}
