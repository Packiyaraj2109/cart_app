class ProductDetailsModel {
  String id;
  String name;
  String decription;
  String price;
  String image;
  bool favourite = false;
  int count;

  ProductDetailsModel(
      {this.id,
      this.name,
      this.decription,
      this.price,
      this.image,
      this.favourite,
      this.count});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    decription = json['decription'];
    price = json['price'];
    image = json['image'];
    favourite = json['favourite'] ?? false;
    count = json['count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['decription'] = this.decription;
    data['price'] = this.price;
    data['image'] = this.image;
    data['favourite'] = this.favourite;
    data['count'] = this.count;
    return data;
  }
}
