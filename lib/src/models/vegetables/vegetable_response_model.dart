import 'package:cart_app/src/models/common/product_details_model.dart';

class VegetabeResponseModel {
  List<ProductDetailsModel> vegetables;

  VegetabeResponseModel({this.vegetables});

  VegetabeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['vegetables'] != null) {
      vegetables = new List<ProductDetailsModel>();
      json['vegetables'].forEach(
        (v) {
          vegetables.add(new ProductDetailsModel.fromJson(v));
        },
      );
      vegetables.sort(
        (a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vegetables != null) {
      data['vegetables'] = this.vegetables.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
