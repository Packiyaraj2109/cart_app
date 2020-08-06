part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeChangeState extends HomeState {}

class ItemDisplayState extends HomeState {
  List<ProductDetailsModel> productListFruits;
  List<ProductDetailsModel> productListVegetables;

  ItemDisplayState(this.productListFruits, this.productListVegetables);
}

class AddToCartState extends HomeState {
  List<ProductDetailsModel> cartitems;
  String msg;
  AddToCartState({this.cartitems,this.msg});
}

class ItemQuantityState extends HomeState {
  
}