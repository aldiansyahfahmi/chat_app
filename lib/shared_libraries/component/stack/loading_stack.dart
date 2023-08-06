import '/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';

class LoadingStack {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            ColorName.white,
          ),
        ));
      },
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
