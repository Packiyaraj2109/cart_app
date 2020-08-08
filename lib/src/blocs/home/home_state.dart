part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class SnackbarState extends HomeState {
  String msg;
  SnackbarState(this.msg);
}

class HomeChangeState extends HomeState {}

class ItemDisplayState extends HomeState {
  List<ProductDetailsModel> productListFruits;
  List<ProductDetailsModel> productListVegetables;

  ItemDisplayState(this.productListFruits, this.productListVegetables);
}

class AddToCartState extends HomeState {
  List<ProductDetailsModel> cartitems;
  AddToCartState({this.cartitems});
}

class ItemQuantityState extends HomeState {}
