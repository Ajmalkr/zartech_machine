import 'package:aju_machine_test/controller/auth_controller.dart';
import 'package:aju_machine_test/controller/cart_controller.dart';
import 'package:aju_machine_test/controller/dish_controller.dart';
import 'package:aju_machine_test/data/api/api_client.dart';
import 'package:aju_machine_test/data/repository/auth_repo.dart';
import 'package:aju_machine_test/data/repository/cart_repo.dart';
import 'package:aju_machine_test/data/repository/dish_repo.dart';
import 'package:aju_machine_test/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.DATA_URL, sharedPreferences: Get.find()));

  // Repository

  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => DishRepo(apiClient: Get.find()));

  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  Get.lazyPut(() => DishController(dishRepo: Get.find()));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
