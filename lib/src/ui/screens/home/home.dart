import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [fruitsTabView(), vegetablesTabView()];
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appthemecolor,
          appBar: PreferredSize(
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
                          child: Text(AppTextConstants.Home,                              
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24),
                            ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20.0,
                          color: Colors.green,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: _tabbar(),
              elevation: 0.0,
            ),
          ),
          body: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }

  GridView vegetablesTabView() {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red),
        )
      ],
    );
  }

  GridView fruitsTabView() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (18 / 19),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
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
                      AppImages.appLogo(width: 120, height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Apple",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "₹100.00",
                            style: TextStyle(
                              fontSize: 21,
                              color: AppColors.borderColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  child: IconButton(
                      splashColor: AppColors.appthemecolor,
                      icon: new Icon(
                        Icons.favorite_border,
                        color: (_isPressed) ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPressed = !_isPressed;
                        });
                      }),
                  alignment: Alignment.topRight,
                ),
                Align(
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.shop,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                )
              ],
            ),
          ),
        ),
      ],
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
            "Fruits",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.only(bottom: 2),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Vegetables",
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
        insets: EdgeInsets.only(right: 140, left: 16),
      ),
    );
  }
}
