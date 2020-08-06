part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeProductDisplayEvent extends HomeEvent {}

class CartProductAddEvent extends HomeEvent {
  String action;
  ProductDetailsModel productItem;
  CartProductAddEvent(this.action,this.productItem);
}

class ItemQuantityModifyEvent extends HomeEvent {
  int index;
  String action;
  ItemQuantityModifyEvent(this.index,this.action);

}
