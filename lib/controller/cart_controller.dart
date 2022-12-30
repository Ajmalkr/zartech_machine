import 'package:aju_machine_test/data/model/dishes_model.dart';
import 'package:aju_machine_test/data/repository/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({@required this.cartRepo});

  List<CategoryDishes> _cartList = [];
  double _amount = 0.0;

  List<CategoryDishes> get cartList => _cartList;
  double get amount => _amount;

  void updateCart(CategoryDishes dishes, bool increment) {
    if (increment) {
      if (_cartList.contains(dishes)) {
        cartList[cartList.indexOf(dishes)].quantity++;
        dishes.quantity = cartList[cartList.indexOf(dishes)].quantity;
      } else {
        dishes.quantity++;
        cartList.add(dishes);
      }
    } else {
      if (_cartList.contains(dishes)) {
        if (cartList[cartList.indexOf(dishes)].quantity > 0) {
          cartList[cartList.indexOf(dishes)].quantity--;
          dishes.quantity = cartList[cartList.indexOf(dishes)].quantity;
        }
        if (cartList[cartList.indexOf(dishes)].quantity == 0) {
          cartList.remove(dishes);
        }
      }
    }
    update();
  }
}
