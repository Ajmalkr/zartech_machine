import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:aju_machine_test/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final String orderID;
  final int status;
  OrderSuccessfulScreen({@required this.orderID, @required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/checked.png", width: 100, height: 100),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Text(
                      "Order Placed Successfully",
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: CustomButton(
                          buttonText: 'Back to Home',
                          onPressed: () =>
                              Get.offAllNamed(RouteHelper.getHomeRoute())),
                    ),
                  ]))),
    );
  }
}
