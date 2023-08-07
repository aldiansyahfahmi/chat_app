import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/auth/ui/sign_in_screen.dart';
import 'package:chat_app/presentation/auth/ui/sign_up_screen.dart';
import 'package:chat_app/presentation/chat/ui/chat_screen.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit/splash_cubit.dart';
import 'package:chat_app/presentation/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../shared_libraries/utils/navigation/navigation_helper.dart';
import '../shared_libraries/utils/navigation/router/app_routes.dart';
import '../shared_libraries/utils/resources/colors.gen.dart';
import '../shared_libraries/utils/setup/app_setup.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Chat App',
          debugShowCheckedModeBanner: Config.isDebug,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorName.white,
          ),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          home: BlocProvider(
            create: (context) => SplashCubit(
              getTokenUseCase: sl(),
            )..initSplash(),
            child: SplashScreen(),
          ),
          navigatorKey: NavigationHelperImpl.navigatorKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case AppRoutes.signIn:
                return PageTransition(
                  child: SignInScreen(),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.signUp:
                return PageTransition(
                  child: const SignUpScreen(),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.chat:
                return PageTransition(
                  child: const ChatScreen(),
                  type: PageTransitionType.rightToLeft,
                );
              default:
                return PageTransition(
                  child: SplashScreen(),
                  type: PageTransitionType.rightToLeft,
                );
            }
          },
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(context, child, details) {
    return child;
  }
}
