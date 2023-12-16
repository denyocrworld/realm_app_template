//#TEMPLATE reuseable_button
import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

class QButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final IconData? sufixIcon;
  final Color? color;
  final bool spaceBetween;
  final ThemeSize size;
  final double? fontSize;

  QButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.sufixIcon,
    this.color,
    this.spaceBetween = false,
    this.size = ThemeSize.md,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widgetWidth = width ?? MediaQuery.of(context).size.width;
    double widgetHeight = 46.0;
    double widgetFontSize = 16.0;
    double widgetIconSize = 24.0;

    widgetWidth *= size.scaleFactor;
    widgetHeight *= size.scaleFactor;
    widgetFontSize *= size.scaleFactor;
    widgetIconSize *= size.scaleFactor;

    widgetHeight = height ?? widgetHeight;

    return Container(
      width: widgetWidth,
      height: widgetHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? primaryColor,
        ),
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon!,
                size: widgetIconSize,
              ),
              SizedBox(
                width: 6.0,
              ),
            ],
            if (spaceBetween && icon != null) Spacer(),
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize ?? widgetFontSize,
                color: Colors.white,
              ),
            ),
            if (spaceBetween && sufixIcon != null) Spacer(),
            if (sufixIcon != null) ...[
              Icon(
                sufixIcon!,
                size: widgetIconSize,
              ),
              SizedBox(
                width: 6.0,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

//#END
