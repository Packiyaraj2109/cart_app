class ProductResponseModel {
  List<ProductList> productList;

  ProductResponseModel({this.productList});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['productList'] != null) {
      productList = new List<ProductList>();
      json['productList'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productList != null) {
      data['productList'] = this.productList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String id;
  String name;
  String decription;
  String price;
  String image;

  ProductList({this.id, this.name, this.decription, this.price, this.image});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    decription = json['decription'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['decription'] = this.decription;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}