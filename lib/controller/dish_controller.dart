import 'package:aju_machine_test/data/api/api_checker.dart';
import 'package:aju_machine_test/data/model/dishes_model.dart';
import 'package:aju_machine_test/data/repository/dish_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DishController extends GetxController implements GetxService {
  final DishRepo dishRepo;
  DishController({@required this.dishRepo});

  DishesModel _dishesModel;
  int _currentIndex = 0;
  bool _loading = false;

  DishesModel get dishesModel => _dishesModel;

  int get currentIndex => _currentIndex;
  bool get loading => _loading;

  Future<void> getDishList(bool reload) async {
    if (_dishesModel == null || reload) {
      _loading = true;
      update();
      Response response = await dishRepo.getDishList();
      if (response.statusCode == 200) {
        _dishesModel = DishesModel.fromJson(response.body);
      } else {
        ApiChecker.checkApi(response);
      }
      _loading = false;
      update();
    }
  }
}
