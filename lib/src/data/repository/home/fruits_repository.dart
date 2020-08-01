import 'package:cart_app/src/data/network/http_client.dart';
import 'package:cart_app/src/constants/api_urls_constants.dart';
import 'package:cart_app/src/models/fruits/product_response_model.dart';

class   FruitRepository {

  Future<FruitResponseModel> fetchproducts() async {
    Map resp =
        await HttpClient().getMethod(ApiUrlsConstants.productFruits); //(users).
        // print("sdf$resp");
    return FruitResponseModel.fromJson(resp);
  }
  
}
