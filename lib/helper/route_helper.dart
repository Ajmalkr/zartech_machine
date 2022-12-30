import 'package:aju_machine_test/view/screens/auth/choose_login_screen.dart';
import 'package:aju_machine_test/view/screens/auth/sign_in_screen.dart';
import 'package:aju_machine_test/view/screens/cart/cart_screen.dart';
import 'package:aju_machine_test/view/screens/checkout/order_successful_screen.dart';
import 'package:aju_machine_test/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/sign-in';
  static const String home = '/home';
  static const String orderSuccess = '/order-successful';
  static const String cart = '/cart';

  static String getInitialRoute() => '$initial';

  static String getSignInRoute() => '$signIn';

  static String getHomeRoute() => '$home';
  static String getCartRoute() => '$cart';

  static String getOrderSuccessRoute() => '$orderSuccess';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => ChooseLoginScreen(exitFromApp: false)),
    GetPage(name: signIn, page: () => SignInScreen(exitFromApp: false)),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: cart, page: () => CartScreen(fromNav: true)),
    GetPage(
        name: orderSuccess,
        page: () => getRoute(OrderSuccessfulScreen(
              orderID: Get.parameters['id'],
              status: Get.parameters['status'].contains('success') ? 1 : 0,
            ))),
  ];

  static getRoute(Widget navigateTo) {
    return navigateTo;
  }
}
