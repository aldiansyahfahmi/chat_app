import '/shared_libraries/component/divider/custom_divider.dart';
import '/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChevronButton extends StatelessWidget {
  final String label;
  final String? subTitle;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool divider;
  final bool iconChevronRight;
  final GestureTapCallback onTap;

  const ChevronButton({
    Key? key,
    required this.label,
    this.subTitle,
    this.prefixWidget,
    this.suffixWidget,
    required this.onTap,
    this.divider = true,
    this.iconChevronRight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: ColorName.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (prefixWidget != null) prefixWidget!,
                          if (prefixWidget != null) const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  label,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: ColorName.black),
                                ),
                                if (subTitle != null)
                                  Text(
                                    subTitle!,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: ColorName.black),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (suffixWidget != null) suffixWidget!,
                    if (suffixWidget != null)
                      SizedBox(
                        width: 8.w,
                      ),
                    if (iconChevronRight == true)
                      Icon(
                        Icons.chevron_right,
                        color: ColorName.blue,
                        size: 24.sp,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (divider == true) const CustomDivider(),
      ],
    );
  }
}
