import 'package:aju_machine_test/util/dimensions.dart';
import 'package:aju_machine_test/util/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final bool transparent;
  final bool isProcessing;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final IconData icon;
  CustomButton(
      {this.onPressed,
      @required this.buttonText,
      this.transparent = false,
      this.isProcessing = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width : Dimensions.WEB_MAX_WIDTH,
          height != null ? height : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
        child: SizedBox(
            width: width != null ? width : Dimensions.WEB_MAX_WIDTH,
            child: Padding(
              padding: margin == null ? EdgeInsets.all(0) : margin,
              child: !isProcessing
                  ? TextButton(
                      onPressed: onPressed,
                      style: _flatButtonStyle,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon != null
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: Icon(icon,
                                        color: transparent
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor),
                                  )
                                : SizedBox(),
                            Text(buttonText ?? '',
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: transparent
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                                  fontSize: fontSize != null
                                      ? fontSize
                                      : Dimensions.fontSizeLarge,
                                )),
                          ]),
                    )
                  : Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      height: height != null ? 50 : height,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor,
                          borderRadius: BorderRadius.circular(radius)),
                      child: Center(child: CircularProgressIndicator()),
                    ),
            )));
  }
}
