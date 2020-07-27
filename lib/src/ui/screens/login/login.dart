import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/data/repository/login/login_repository.dart';
import 'package:cart_app/src/models/login/login_response_model.dart';
import 'package:cart_app/src/models/login/product_response_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBackgroundColor,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          AppTextConstants.USER_NAME,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: AppColors.appBackgroundColor,
                          ),
                          child: TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.appBackgroundColor)),
                              ),
                              keyboardType: TextInputType.multiline),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(AppTextConstants.PASSWORD,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: AppColors.appBackgroundColor,
                          ),
                          child: TextField(
                              controller: _passwordController,
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.appBackgroundColor)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.appBackgroundColor,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.multiline),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 32),
                          width: 400,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: AppColors.appBackgroundColor,
                            onPressed: _dataFetch,
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Future<void> _dataFetch() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    LoginResponseModel userList = await LoginRepository().fetchUser();
    ProductResponseModel productList = await LoginRepository().fetchproducts();
    int index = userList.userList.indexWhere((UserList element) =>
        element.username == username && element.password == password);
    if (index != -1) {
      Navigator.of(context).pushNamed('home');
    } else {
      print("Failed");
    }
  }
}
