import '/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final int buttonBorderRadius;
  final String buttonText;
  final Color buttonTextColor;
  final Color? borderColor;
  final int buttonTextSize;
  final FontWeight buttonTextFontWeight;
  final Widget? icon;
  final GestureTapCallback onTap;

  const CustomButton({
    Key? key,
    this.buttonColor = ColorName.blue,
    required this.buttonText,
    this.buttonTextColor = ColorName.white,
    this.borderColor,
    this.buttonBorderRadius = 12,
    this.buttonTextSize = 14,
    this.buttonTextFontWeight = FontWeight.w500,
    this.icon,
    required this.onTap,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 24),
        backgroundColor: buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: borderColor != null ? borderColor! : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon != null)
            const SizedBox(
              width: 12.0,
            ),
          Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontSize: buttonTextSize.sp,
              fontWeight: buttonTextFontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
