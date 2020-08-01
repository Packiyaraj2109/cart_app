import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/data/repository/login/login_repository.dart';
import 'package:cart_app/src/models/login/login_response_model.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
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
        body: _bodyBuild(),
      ),
    );
  }

  Center _bodyBuild() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: SingleChildScrollView(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                color: AppColors.gridbackground,
              ),
              width: double.infinity,
              padding: EdgeInsets.only(left: 40, right: 40,top:16,bottom:16),
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
                    child: Text(
                      AppTextConstants.PASSWORD,
                      style: Theme.of(context).textTheme.headline2,
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
                              onPressed: _passwordVisible,
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
                          AppTextConstants.LOGIN,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _passwordVisible() {
    setState(
      () {
        passwordVisible = !passwordVisible;
      },
    );
  }

  Future<void> _dataFetch() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    LoginResponseModel userList = await LoginRepository().fetchUser();
    int index = userList.userList.indexWhere((UserList element) =>
        element.username == username && element.password == password);
    if (index != -1) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(ScreenRoutes.HOMEPAGE);
    } else {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _showScaffold(AppTextConstants.LoginErrorMsg);
    }
  }

  _showScaffold(String message) {
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
