import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../constants/app_text_constants.dart';
import '../../data/repository/login/login_repository.dart';
import '../../models/login/login_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginValidationEvent) {

     LoginResponseModel userList = await LoginRepository().fetchUser();
    yield LoginFailedFailedState(userList.userList);
      // String username = event.username;
      // String password = event.password;
      // if (username == '') {
      //   yield LoginFailedFailedState(AppTextConstants.EnterUserName);
      // } else if (password == '') {
      //   yield LoginFailedFailedState(AppTextConstants.EnterPassword);
      // } else {
      //   LoginResponseModel userList = await LoginRepository().fetchUser();
      //   int index = userList.userList.indexWhere((UserList element) =>
      //       element.username == username && element.password == password);
      //   if (index != -1) {
      //     yield LoginValidateSuccessState();
      //   } else {
      //     yield LoginFailedFailedState(AppTextConstants.LoginErrorMsg);
      //   }
      // }
    }
  }
}
