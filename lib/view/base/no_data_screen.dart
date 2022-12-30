import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  final bool isCart;
  final String text;
  NoDataScreen({@required this.text, this.isCart = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              isCart ? "Cart Is Empty" : text,
              style: robotoMedium.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
