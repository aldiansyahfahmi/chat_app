import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit/splash_cubit.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit/splash_state.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/splash_router.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashRouter splashRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          final status = state.splashState.status;
          if (status.isHasData) {
            splashRouter.navigateToChatScreen();
          }

          if (status.isNoData) {
            splashRouter.navigateToSignInScreen();
          }
        },
        child: const Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
