import 'package:aju_machine_test/controller/auth_controller.dart';
import 'package:aju_machine_test/controller/cart_controller.dart';
import 'package:aju_machine_test/controller/dish_controller.dart';
import 'package:aju_machine_test/data/model/dishes_model.dart';
import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:aju_machine_test/view/base/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static Future<void> loadData(bool reload) async {
    await Get.find<DishController>().getDishList(true);
  }

  @override
  Widget build(BuildContext context) {
    loadData(false);

    return Scaffold(
      body: GetBuilder<DishController>(builder: (dishController) {
        DishesModel dishesModel = dishController.dishesModel;
        return dishController.loading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              )
            : DefaultTabController(
                length: dishesModel.tableMenuList.length,
                child: Scaffold(
                    drawer: Drawer(
                      child: Column(
                        children: [
                          Container(
                            height: Get.height * 0.36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.green[600],
                              Colors.green[300]
                            ])),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/image/user.png",
                                  scale: 5,
                                ),
                                Text(
                                  "${Get.find<AuthController>().getUser()}",
                                  style: robotoMedium.copyWith(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.find<AuthController>().clearSharedData();
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteHelper.getInitialRoute(),
                                    (route) => false);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Logout",
                                    style: robotoMedium.copyWith(
                                        color: Colors.black54, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    appBar: AppBar(
                      centerTitle: true,
                      bottom: PreferredSize(
                          child: TabBar(
                              isScrollable: true,
                              unselectedLabelColor:
                                  Colors.white.withOpacity(0.3),
                              indicatorColor: Colors.white,
                              tabs: [
                                for (int i = 0;
                                    i < dishesModel.tableMenuList.length;
                                    i++)
                                  Tab(
                                    child: Text(
                                        '${dishesModel.tableMenuList[i].menuCategory}'),
                                  ),
                              ]),
                          preferredSize: Size.fromHeight(30.0)),
                      actions: <Widget>[
                        GetBuilder<CartController>(builder: (cartController) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteHelper.getCartRoute());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    height: 150.0,
                                    width: 30.0,
                                    child: Stack(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                          onPressed: null,
                                        ),
                                        Positioned(
                                            child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 3.0,
                                                right: -1.0,
                                                child: Container(
                                                  width: 15,
                                                  height: 15,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Text(
                                                    "${cartController.cartList.length}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )),
                                          ],
                                        )),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    body: TabBarView(
                      children: <Widget>[
                        for (int i = 0;
                            i < dishesModel.tableMenuList.length;
                            i++)
                          Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int n = 0;
                                      n <
                                          dishesModel.tableMenuList[i]
                                              .categoryDishes.length;
                                      n++)
                                    Container(
                                      // height: Get.height * 0.3,
                                      width: Get.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide())),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: dishesModel
                                                                .tableMenuList[
                                                                    i]
                                                                .categoryDishes[
                                                                    n]
                                                                .dishType ==
                                                            2
                                                        ? Colors.green
                                                        : Colors.red,
                                                    width: 2)),
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: dishesModel
                                                              .tableMenuList[i]
                                                              .categoryDishes[n]
                                                              .dishType ==
                                                          2
                                                      ? Colors.green
                                                      : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  // width: Get.width * 0.4,
                                                  child: Text(
                                                    "${dishesModel.tableMenuList[i].categoryDishes[n].dishName}",
                                                    style:
                                                        robotoMedium.copyWith(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 17),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${dishesModel.tableMenuList[i].categoryDishes[n].dishPrice} INR",
                                                      style:
                                                          robotoMedium.copyWith(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 17),
                                                    ),
                                                    Text(
                                                      "${dishesModel.tableMenuList[i].categoryDishes[n].dishCalories} Calories",
                                                      style:
                                                          robotoMedium.copyWith(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 17),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "${dishesModel.tableMenuList[i].categoryDishes[n].dishDescription}",
                                                  style: robotoMedium.copyWith(
                                                      color: Colors.black38,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                GetBuilder<CartController>(
                                                    builder: (cartController) {
                                                  return Container(
                                                    height: Get.height * 0.05,
                                                    width: Get.width * 0.35,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.green),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            // cartController
                                                            //     .removeFromCart(
                                                            //         n);
                                                            cartController.updateCart(
                                                                dishesModel
                                                                    .tableMenuList[
                                                                        i]
                                                                    .categoryDishes[n],
                                                                false);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${dishesModel.tableMenuList[i].categoryDishes[n].quantity}",
                                                          style: robotoMedium
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            cartController.updateCart(
                                                                dishesModel
                                                                    .tableMenuList[
                                                                        i]
                                                                    .categoryDishes[n],
                                                                true);
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
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                if (dishesModel
                                                        .tableMenuList[i]
                                                        .categoryDishes[n]
                                                        .addonCat
                                                        .length >
                                                    0)
                                                  Text(
                                                    "Customization Available",
                                                    style:
                                                        robotoMedium.copyWith(
                                                            color: Colors
                                                                .redAccent,
                                                            fontSize: 16.5),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          CustomImage(
                                            image:
                                                "${dishesModel.tableMenuList[i].categoryDishes[n].dishImage}",
                                            width: 50,
                                            height: 50,
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                      ],
                    )),
              );
      }),
    );
  }
}
