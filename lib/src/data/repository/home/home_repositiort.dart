import 'package:cart_app/api_get.dart';
import 'package:cart_app/src/constants/api_urls_constants.dart';
import 'package:cart_app/src/models/login/product_response_model.dart';

class   ProductRepository {

  Future<ProductResponseModel> fetchproducts() async {
    Map resp =
        await HttpClient().getMethod(ApiUrlsConstants.productList); //(users).
        // print("sdf$resp");
    return ProductResponseModel.fromJson(resp);
  }
  
}
