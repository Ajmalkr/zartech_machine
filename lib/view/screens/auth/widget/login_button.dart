import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(1, 40),
      ),
      onPressed: () {
        Get.toNamed(RouteHelper.getSignInRoute());
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '${'already_a_member'.tr} ',
            style:
                robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
        TextSpan(
            text: 'sign_in'.tr,
            style:
                robotoMedium.copyWith(color: Theme.of(context).indicatorColor)),
      ])),
    );
  }
}
