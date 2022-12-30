import 'package:aju_machine_test/controller/auth_controller.dart';
import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/image/logo.png",
            scale: 3,
            // width: 20,
            // height: 20,
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Column(
            children: [
              InkWell(
                onTap: () async {
                  GoogleSignInAccount _googleAccount =
                      await GoogleSignIn().signIn();
                  GoogleSignInAuthentication _auth =
                      await _googleAccount.authentication;
                  if (_googleAccount != null) {
                    Get.find<AuthController>()
                        .saveUser(_googleAccount.displayName);
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteHelper.getHomeRoute(), (route) => false);
                  }
                },
                child: Container(
                  height: 50,
                  width: Get.width * 0.7,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[Get.isDarkMode ? 700 : 300],
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.asset(
                            "assets/image/google.png",
                            width: 20,
                            height: 20,
                          )),
                      SizedBox(
                        width: Get.width * 0.2,
                      ),
                      Text(
                        "Google",
                        style: robotoBold.copyWith(
                            color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteHelper.getSignInRoute());
                  // Navigator.pushNamed(context, RouteHelper.getHomeRoute());
                },
                child: Container(
                  height: 50,
                  width: Get.width * 0.7,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[Get.isDarkMode ? 700 : 300],
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(
                        width: Get.width * 0.2,
                      ),
                      Text(
                        "Phone",
                        style: robotoBold.copyWith(
                            color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        ]);
  }
}
