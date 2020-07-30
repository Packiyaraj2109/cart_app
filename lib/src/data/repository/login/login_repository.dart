import 'package:cart_app/api_get.dart';
import 'package:cart_app/src/constants/api_urls_constants.dart';
import 'package:cart_app/src/models/login/login_response_model.dart';

class   LoginRepository {
  Future<LoginResponseModel> fetchUser() async {
    Map resp =
        await HttpClient().getMethod(ApiUrlsConstants.userList); //(users).
    return LoginResponseModel.fromJson(resp);
  }
  
}



