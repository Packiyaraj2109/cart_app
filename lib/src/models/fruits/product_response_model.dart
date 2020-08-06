import 'package:cart_app/src/models/common/product_details_model.dart';

class FruitResponseModel {
  List<ProductDetailsModel> fruits;

  FruitResponseModel({this.fruits});

  FruitResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['fruits'] != null) {
      fruits = new List<ProductDetailsModel>();

      json['fruits'].forEach(
        (v) {
          fruits.add(new ProductDetailsModel.fromJson(v));
        },
      );
      fruits.sort(
        (a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        },
      );
    }
  }

  int get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fruits != null) {
      data['fruits'] = this.fruits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
