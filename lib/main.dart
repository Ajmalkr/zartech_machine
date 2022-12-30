import 'dart:async';
import 'dart:io';

import 'package:aju_machine_test/controller/auth_controller.dart';
import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  bool isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Machine Test",
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      initialRoute: isLoggedIn
          ? RouteHelper.getHomeRoute()
          : RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
