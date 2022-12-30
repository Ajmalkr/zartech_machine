import 'package:aju_machine_test/controller/cart_controller.dart';
import 'package:aju_machine_test/data/model/dishes_model.dart';
import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:aju_machine_test/view/base/custom_app_bar.dart';
import 'package:aju_machine_test/view/base/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final fromNav;

  CartScreen({@required this.fromNav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'my_cart'.tr,
          isBackButtonExist: (!fromNav)),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteHelper.getOrderSuccessRoute());
        },
        child: Container(
          height: 50,
          width: Get.width * 0.8,
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green[900],
              borderRadius: BorderRadius.circular(40)),
          child: Text(
            "Place Order",
            style: robotoRegular.copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GetBuilder<CartController>(
        builder: (cartController) {
          List<CategoryDishes> dish = cartController.cartList;

          String getTotalItems(List<CategoryDishes> cartList) {
            int quant = 0;
            cartList.forEach((element) {
              quant += element.quantity;
            });
            return quant.toString();
          }

          String getTotalPrice(List<CategoryDishes> cartList) {
            double amount = 0;
            cartList.forEach((element) {
              amount += element.quantity * element.dishPrice;
            });
            return amount.toStringAsFixed(2);
          }

          return dish.length > 0
              ? Column(
                  children: [
                    Container(
                      height: Get.height * 0.06,
                      width: Get.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green[900],
                      ),
                      child: Text(
                        "${dish.length} Dishes - ${getTotalItems(dish)} Items",
                        style: robotoMedium.copyWith(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < dish.length; i++)
                      Container(
                        // height: Get.height * 0.3,
                        width: Get.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration:
                            BoxDecoration(border: Border(bottom: BorderSide())),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: dish[i].dishType == 2
                                            ? Colors.green
                                            : Colors.red,
                                        width: 2)),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: dish[i].dishType == 2
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.28,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      // width: Get.width * 0.4,
                                      child: Text(
                                        "${dish[i].dishName}",
                                        style: robotoMedium.copyWith(
                                            color: Colors.black54,
                                            fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${dish[i].dishPrice} INR",
                                      style: robotoMedium.copyWith(
                                          color: Colors.black54, fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${dish[i].dishCalories} Calories",
                                      style: robotoMedium.copyWith(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                              GetBuilder<CartController>(
                                  builder: (cartController) {
                                return Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.3,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green[900]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // cartController
                                          //     .removeFromCart(
                                          //         n);
                                          cartController.updateCart(
                                              dish[i], false);
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${dish[i].quantity}",
                                        style: robotoMedium.copyWith(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cartController.updateCart(
                                              dish[i], true);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Text(
                                "${(dish[i].dishPrice * dish[i].quantity).toStringAsFixed(2)} INR",
                                style: robotoMedium.copyWith(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: robotoMedium.copyWith(
                                color: Colors.black54, fontSize: 18),
                          ),
                          Text(
                            "${getTotalPrice(dish)} INR",
                            style: robotoMedium.copyWith(
                                color: Colors.black54, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : NoDataScreen(isCart: true, text: '');
        },
      ),
    );
  }
}
