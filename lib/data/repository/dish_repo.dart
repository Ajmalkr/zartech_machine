import 'package:aju_machine_test/data/api/api_client.dart';
import 'package:aju_machine_test/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class DishRepo {
  final ApiClient apiClient;
  DishRepo({@required this.apiClient});

  Future<Response> getDishList() async {
    return await apiClient.getData(AppConstants.DATA_URL);
  }
}
