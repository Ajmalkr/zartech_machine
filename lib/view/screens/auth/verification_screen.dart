import 'dart:async';

import 'package:aju_machine_test/controller/auth_controller.dart';
import 'package:aju_machine_test/helper/route_helper.dart';
import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:aju_machine_test/view/base/custom_app_bar.dart';
import 'package:aju_machine_test/view/base/custom_button.dart';
import 'package:aju_machine_test/view/base/custom_dialog.dart';
import 'package:aju_machine_test/view/base/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final String number;
  VerificationScreen({
    @required this.number,
  });

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _number;
  Timer _timer;
  int _seconds = 0;
  String verificationId;
  String smsCode;
  String token;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _number = widget.number.startsWith('+')
        ? widget.number
        : '+' + widget.number.substring(1, widget.number.length);
    sendVerificationCode(phoneNumber: _number);
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer?.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'OTP VERIFICATION'),
      body: SafeArea(
          child: Center(
              child: Scrollbar(
                  child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Center(
            child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700
              ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
              : null,
          decoration: context.width > 700
              ? BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[Get.isDarkMode ? 700 : 300],
                        blurRadius: 5,
                        spreadRadius: 1)
                  ],
                )
              : null,
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(children: [
              Image.asset("assets/image/logo.png", width: 100),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Enter the verification code send to",
                    style: robotoRegular.copyWith(
                        color: Theme.of(context).disabledColor)),
                TextSpan(
                    text: ' $_number',
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyText1.color)),
              ])),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: PinCodeTextField(
                  length: 6,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 40,
                    borderWidth: 1,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor: Colors.white,
                    inactiveFillColor:
                        Theme.of(context).disabledColor.withOpacity(0.2),
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    activeFillColor:
                        Theme.of(context).disabledColor.withOpacity(0.2),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  // onChanged: authController.updateVerificationCode,
                  onChanged: (v) async {
                    smsCode = v;
                  },
                  beforeTextPaste: (text) => true,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Did not receive otp ?',
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).disabledColor),
                ),
                TextButton(
                  onPressed: _seconds < 1
                      ? () {
                          sendVerificationCode(phoneNumber: _number);
                        }
                      : null,
                  child: Text(
                      '${'resend'.tr}${_seconds > 0 ? ' ($_seconds)' : ''}'),
                ),
              ]),
              smsCode != null && smsCode.length == 6
                  ? !authController.isLoading
                      ? CustomButton(
                          buttonText: 'verify'.tr,
                          onPressed: () async {
                            // if (widget.fromSignUp) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: smsCode))
                                  .then((value) {
                                if (value.user != null) {
                                  //
                                  Get.find<AuthController>()
                                      .saveUser(value.user.phoneNumber);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteHelper.getHomeRoute(),
                                      (route) => false);
                                }
                              });
                            } catch (e) {
                              FocusScope.of(context).unfocus();
                              showCustomSnackBar('invalid OTP', isError: true);
                            }
                          },
                        )
                      : Center(child: CircularProgressIndicator())
                  : SizedBox.shrink(),
            ]);
          }),
        )),
      )))),
    );
  }

  void successDialog(BuildContext context) {
    return showAnimatedDialog(
        context,
        Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset("assets/image/checked.png", width: 100, height: 100),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Text('verified'.tr,
                  style: robotoBold.copyWith(
                    fontSize: 30,
                    color: Theme.of(context).textTheme.bodyText1.color,
                    decoration: TextDecoration.none,
                  )),
            ]),
          ),
        ),
        dismissible: false);
  }

  Future<dynamic> sendVerificationCode({@required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  Future<dynamic> phoneSignIn({@required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User user = FirebaseAuth.instance.currentUser;

    if (authCredential.smsCode != null) {
      successDialog(context);

      try {
        UserCredential credential =
            await user.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      // showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }
}
