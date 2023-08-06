import '/shared_libraries/utils/constants/app_constants.dart';
import '/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_bar/custom_app_bar.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final GestureTapCallback onTap;
  const ErrorView({super.key, required this.error, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: const CustomAppBar(title: '').preferredSize.height),
      padding: EdgeInsets.all(AppConstants.app.defaultMargin),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error == 'null' ? 'Terjadi kesalahan, coba lagi' : error,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: onTap,
              style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.refresh,
                    color: ColorName.blue,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorName.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
