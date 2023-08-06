import '/shared_libraries/component/button/custom_button.dart';
import '/shared_libraries/utils/resources/assets.gen.dart';
import '/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DialogType { success, failed, custom }

class CustomDialog {
  static void show({
    required BuildContext context,
    required DialogType type,
    required String title,
    required subTitle,
    required String buttonText,
    required GestureTapCallback onTap,
    bool cancelButton = true,
    Function? onDismissible,
  }) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  type != DialogType.custom
                      ? type == DialogType.success
                          ? Assets.images.icons.dialog.success
                              .svg(width: 95, height: 95)
                          : Assets.images.icons.dialog.failed
                              .svg(width: 95, height: 95)
                      : const SizedBox(),
                  SizedBox(
                    height: type == DialogType.custom ? 0 : 24,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: ColorName.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: ColorName.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  type == DialogType.custom
                      ? Row(
                          children: [
                            if (cancelButton == true)
                              Expanded(
                                child: CustomButton(
                                  buttonText: 'Batal',
                                  buttonColor: ColorName.white,
                                  borderColor: ColorName.blue,
                                  buttonTextColor: ColorName.blue,
                                  onTap: () => Navigator.pop(context),
                                ),
                              ),
                            if (cancelButton == true)
                              const SizedBox(
                                width: 16.0,
                              ),
                            Expanded(
                              child: CustomButton(
                                buttonText: buttonText,
                                onTap: onTap,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                buttonText: buttonText,
                                onTap: onTap,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    ).then((value) {
      if (onDismissible != null) {
        onDismissible();
      }
    });
  }
}
