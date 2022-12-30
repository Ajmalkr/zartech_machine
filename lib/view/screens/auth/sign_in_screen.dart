import 'dart:async';
import 'dart:io';

import 'package:aju_machine_test/controller/auth_controller.dart';
import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:aju_machine_test/view/base/custom_button.dart';
import 'package:aju_machine_test/view/base/custom_snackbar.dart';
import 'package:aju_machine_test/view/base/custom_text_field.dart';
import 'package:aju_machine_test/view/screens/auth/verification_screen.dart';
import 'package:aju_machine_test/view/screens/auth/widget/code_picker_widget.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  SignInScreen({@required this.exitFromApp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryDialCode;
  bool _canExit = GetPlatform.isWeb ? true : false;
  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();

    _countryDialCode = "+91";
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
        body: SafeArea(
            child: Center(
          child: Container(
            width: context.width > 700 ? 700 : context.width,
            padding: context.width > 700
                ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                : null,
            alignment: Alignment.center,
            decoration: context.width > 700
                ? BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[Get.isDarkMode ? 700 : 300],
                          blurRadius: 5,
                          spreadRadius: 1)
                    ],
                  )
                : null,
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    Text('Welcome'.toUpperCase(),
                        style: robotoBlack.copyWith(fontSize: 18)),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Colors.grey[Get.isDarkMode ? 800 : 200],
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                          ),
                          child: Row(children: [
                            CodePickerWidget(
                              onChanged: (CountryCode countryCode) {
                                _countryDialCode = countryCode.dialCode;
                              },
                              initialSelection: _countryDialCode,
                              favorite: [_countryDialCode],
                              showDropDownButton: false,
                              padding: EdgeInsets.zero,
                              showFlagMain: true,
                              enabled: false,
                              flagWidth: 30,
                              textStyle: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  hintText: 'Mobile Number',
                                  controller: _phoneController,
                                  focusNode: _phoneFocus,
                                  nextFocus: _passwordFocus,
                                  inputType: TextInputType.phone,
                                  divider: false,
                                )),
                          ]),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ]),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    !authController.isLoading
                        ? Column(
                            children: [
                              Container(
                                  width: width * 0.9,
                                  child: CustomButton(
                                    buttonText: "Sign In",
                                    onPressed: () => _login(
                                        authController, _countryDialCode),
                                  )),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30),
                  ]);
            }),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController, String countryDialCode) async {
    String _phone = _phoneController.text.trim();
    String _numberWithCountryCode = countryDialCode + _phone;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode = '+' + "91" + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }
    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              VerificationScreen(number: _numberWithCountryCode)));
    }
  }
}
