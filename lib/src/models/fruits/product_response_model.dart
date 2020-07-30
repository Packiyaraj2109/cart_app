class FruitResponseModel {
  List<Fruits> fruits;

  FruitResponseModel({this.fruits});

  FruitResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['fruits'] != null) {
      fruits = new List<Fruits>();
      json['fruits'].forEach((v) {
        fruits.add(new Fruits.fromJson(v));
      });
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

class Fruits {
  String id;
  String name;
  String decription;
  String price;
  String image;

  Fruits({this.id, this.name, this.decription, this.price, this.image});

  Fruits.fromJson(Map<String, dynamic> json) {
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