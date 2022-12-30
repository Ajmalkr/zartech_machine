import 'dart:async';
import 'dart:io';

import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/view/screens/auth/widget/social_login_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChooseLoginScreen extends StatefulWidget {
  final bool exitFromApp;
  ChooseLoginScreen({@required this.exitFromApp});

  @override
  _ChooseLoginScreenState createState() => _ChooseLoginScreenState();
}

class _ChooseLoginScreenState extends State<ChooseLoginScreen> {
  bool _canExit = GetPlatform.isWeb ? true : false;
  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: !widget.exitFromApp
            ? AppBar(
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent)
            : null,
        body: SafeArea(child: Center(child: SocialLoginWidget())),
      ),
    );
  }
}
