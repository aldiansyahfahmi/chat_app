import '/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool backButton;
  final List<Widget>? action;
  const CustomAppBar(
      {Key? key,
      required this.title,
      this.centerTitle = false,
      this.backButton = true,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: ColorName.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(color: ColorName.black, size: 24),
      centerTitle: centerTitle,
      titleSpacing: backButton == true ? 0.0 : null,
      automaticallyImplyLeading: backButton,
      backgroundColor: ColorName.white,
      elevation: 0.0,
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
