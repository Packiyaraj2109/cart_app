import 'package:cart_app/api_get.dart';
import 'package:cart_app/src/constants/api_urls_constants.dart';
import 'package:cart_app/src/models/vegetables/vegetable_response_model.dart';

class   VegetableRepository {

  Future<VegetabeResponseModel> fetchproducts() async {
    Map resp =
        await HttpClient().getMethod(ApiUrlsConstants.productVegetables); //(users).
        // print("sdf$resp");
    return VegetabeResponseModel.fromJson(resp);
  }
  
}
