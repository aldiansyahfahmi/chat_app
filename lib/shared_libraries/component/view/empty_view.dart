import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(),
      // child: Assets.images.icons.global.empty.svg(),
    );
  }
}
