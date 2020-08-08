import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/blocs/login/login_bloc.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/models/login/login_response_model.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;
  List<UserList> userList = [];
  var reg = "[a-zA-Z0-9]";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _loginBloc = BlocProvider.of<LoginBloc>(context);
        // _loginBloc.listen(loginBlocListener);
        _loginBloc.add(
          LoginValidationEvent(),
        );
      },
    );
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

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: _bodyBuild(),
      ),
    );
  }

  SingleChildScrollView _bodyBuild() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 8,
          right: 8,
          bottom: 16,
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                AppTextConstants.WELCOME,
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
            AppImages.appLogo2(
              width: double.infinity,
              height: 320,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(
                  Radius.circular(10),
                ),
                color: AppColors.gridbackground,
                boxShadow: [
                  new BoxShadow(
                    color: AppColors.boxshadowcolor,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppTextConstants.Login_MSG,
                    style: Theme.of(context).accentTextTheme.headline5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: AppColors.tabunselected,
                      ),
                      child: TextField(
                          controller: _usernameController,
                          inputFormatters: [
                            new WhitelistingTextInputFormatter(RegExp(reg)),
                          ],
                          // controller: _userNameController,
                          cursorColor: AppColors.tabunselected,
                          decoration: InputDecoration(
                            hintText: AppTextConstants.USER_NAME,
                          ),
                          keyboardType: TextInputType.multiline),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 32,
                    ),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: AppColors.tabunselected,
                      ),
                      child: TextField(
                          controller: _passwordController,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            hintText: AppTextConstants.PASSWORD,
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
                          inputFormatters: [
                            new WhitelistingTextInputFormatter(RegExp(reg)),
                          ],
                          // controller: _userNameController,
                          cursorColor: AppColors.tabunselected,
                          keyboardType: TextInputType.visiblePassword),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _modalBottomSheetMenu(),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "ⓘ ",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline4,
                              ),
                              TextSpan(
                                text: "Users List",
                                style:
                                    Theme.of(context).accentTextTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                          color: AppColors.appBackgroundColor,
                          onPressed: () => _loginValidation(),
                          //_dataFetch,
                          child: Text(
                            AppTextConstants.LOGIN,
                            style: Theme.of(context).accentTextTheme.headline6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (builder) {
        return BlocProvider.value(
          value: _loginBloc,
          child: BlocBuilder<LoginBloc, LoginState>(
            condition: (LoginState previous, LoginState current) {
              return current is LoginFailedFailedState;
            },
            builder: (BuildContext context, LoginState state) {
              if (state is LoginFailedFailedState &&
                  state.userList.isNotEmpty) {
                return _bottomSheetBody(state.userList);
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.appBackgroundColor),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Container _bottomSheetBody(List<UserList> userList) {
    return Container(
      height: 500,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: <Widget>[
          Center(
              child: Text("Available Users",
                  style: Theme.of(context).primaryTextTheme.headline5)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                // Center(
                //     child: Text("Available Users",
                //         style: Theme.of(context).primaryTextTheme.headline5)),
                // SizedBox(height: 10),
                List.generate(
              userList.length,
              (index) {
                UserList user = userList[index];
                // userList = userList;
                return
                    // Center(
                    //     child: Text("Available Users",
                    //         style: Theme.of(context).primaryTextTheme.headline5)),
                    // SizedBox(height: 10),
                    GestureDetector(
                  onTap: () => _userSet(user),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1, color: Theme.of(context).dividerColor),
                      ),
                      color: AppColors.gridbackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "UserID         : ",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .headline3),
                              TextSpan(
                                  text: "   ${user.username}",
                                  style: Theme.of(context).textTheme.headline3),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Password   : ",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .headline3),
                              TextSpan(
                                  text: "   ${user.password}",
                                  style: Theme.of(context).textTheme.headline3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _loginValidation() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username == '') {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _showScaffold(AppTextConstants.EnterUserName);
    } else if (password == '') {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _showScaffold(AppTextConstants.EnterPassword);
    } else {
      int index = userList.indexWhere((UserList element) =>
          element.username == username && element.password == password);
      if (index != -1) {
        _scaffoldKey.currentState.removeCurrentSnackBar();
        _showScaffold(AppTextConstants.LoginErrorMsg);
      } else {
            Navigator.of(context)
        .pushNamedAndRemoveUntil(ScreenRoutes.HOMEPAGE, (route) => false);
      }
    }
  }

  void _passwordVisible() {
    setState(
      () {
        passwordVisible = !passwordVisible;
      },
    );
  }

  _userSet(UserList user) {
    Navigator.pop(context);
    setState(() {
      _usernameController = TextEditingController(text: user.username);
      _passwordController = TextEditingController(text: user.password);
    },);
  }

  // Future<void> _dataFetch() async {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;

  //   // _loginBloc.add(
  //   //   LoginValidationEvent(username, password),
  //   );

  // LoginResponseModel userList = await LoginRepository().fetchUser();
  // int index = userList.userList.indexWhere((UserList element) =>
  //     element.username == username && element.password == password);
  // if (index != -1) {
  //   // Navigator.of(context).pop();
  //   // Navigator.of(context).pushNamed(ScreenRoutes.HOMEPAGE);
  // } else {
  //   _scaffoldKey.currentState.removeCurrentSnackBar();
  //   _showScaffold(AppTextConstants.LoginErrorMsg);
  // }
  // }

  _showScaffold(String message) {
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
