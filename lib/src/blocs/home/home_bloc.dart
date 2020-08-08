import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/data/repository/home/fruits_repository.dart';
import 'package:cart_app/src/data/repository/home/vegetable_repository.dart';
import 'package:cart_app/src/models/common/product_details_model.dart';
import 'package:cart_app/src/models/fruits/product_response_model.dart';
import 'package:cart_app/src/models/vegetables/vegetable_response_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();
  AddToCartState cartItemState = AddToCartState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeProductDisplayEvent) {
      yield* _itemDisplayevent(event);
    } else if (event is CartProductAddEvent) {
      yield* _itemAddCartEvent(event);
    } else if (event is CartProductClearEvent) {
      yield* _listClear();
    }
  }

  Stream<HomeState> _itemDisplayevent(HomeProductDisplayEvent event) async* {
    final FruitResponseModel fruitResponse =
        await FruitRepository().fetchproducts();
    final VegetabeResponseModel vegResponse =
        await VegetableRepository().fetchproducts();
    yield ItemDisplayState(fruitResponse.fruits, vegResponse.vegetables);
  }

  Stream<HomeState> _itemAddCartEvent(CartProductAddEvent event) async* {
    ProductDetailsModel productItem = event.productItem;
    List<ProductDetailsModel> cartitems = cartItemState.cartitems ?? [];
    int index = cartitems.indexWhere((element) =>
        element.id == productItem.id && element.name == productItem.name);
    if (event.action == AppTextConstants.REDUCEPRODUCT) {
      if (productItem.count > 1) {
        productItem.count = productItem.count - 1;
      } else {
        cartitems.removeAt(index);
      }
      yield HomeChangeState();
      yield cartItemState..cartitems = cartitems;
    } else if (event.action == AppTextConstants.ADDPRODUCT) {
      if (index != -1) {
        cartitems[index].count = cartitems[index].count + 1;
      } else {
        productItem.count = 1;
        cartitems.add(productItem);
      }
      yield HomeChangeState();
      yield cartItemState..cartitems = cartitems;
          yield SnackbarState(
        '${productItem.name} Added to cart. Quantity: ${productItem.count}');
    } else {
      cartitems.removeAt(index);
      yield HomeChangeState();
      yield cartItemState..cartitems = cartitems;
    }


    yield cartItemState..cartitems = cartitems;
  }

  Stream<HomeState> _listClear() async* {
    List<ProductDetailsModel> cartitems = cartItemState.cartitems ?? [];
    cartitems.clear();
    yield cartItemState..cartitems = cartitems;
    // yield AddToCartState(cartitems,AppTextConstants.LoginErrorMsg);
  }

  //   Stream<HomeState> _itemQuantityModify(ItemQuantityModifyEvent event) async* {
  //     List<ProductDetailsModel> cartitems = cartItemState.cartitems ?? [];
  //     int index =event.index;
  //     String action=event.action;
  //     print("$action");
  //     if (action == 'reduce') {
  //       if (cartitems[index].count > 1) {
  //         cartitems[index].count = cartitems[index].count - 1;
  //         print("test: ${cartitems[index].count }");
  //       } else {
  //         cartitems.removeAt(index);
  //       }

  //     } else {
  //       if (cartitems[index].count >= 0) {
  //         cartitems[index].count =
  //             cartitems[index].count + 1;
  //       }
  //       print("test: ${cartitems[index].count }");
  //     }

  // }

}
