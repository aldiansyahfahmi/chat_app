import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/account/bloc/user_cubit/user_cubit.dart';
import 'package:chat_app/presentation/auth/bloc/sign_in_with_email_and_password_bloc/sign_in_with_email_and_password_bloc.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_bloc.dart';
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
              isUserLoggedUseCase: sl(),
            )..initSplash(),
            child: SplashScreen(),
          ),
          navigatorKey: NavigationHelperImpl.navigatorKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case AppRoutes.signIn:
                return PageTransition(
                  child: BlocProvider(
                    create: (context) => SignInWithEmailAndPasswordBloc(
                      signInWithEmailAndPasswordUseCase: sl(),
                    ),
                    child: SignInScreen(),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.signUp:
                return PageTransition(
                  child: BlocProvider(
                    create: (context) => SignUpWithEmailAndPasswordBloc(
                      signUpWithEmailAndPasswordUseCase: sl(),
                    ),
                    child: SignUpScreen(),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.chat:
                return PageTransition(
                  child: BlocProvider(
                    create: (context) => UserCubit(
                      getUserUseCase: sl(),
                      getUserByIdUseCase: sl(),
                    )..getUser(),
                    child: const ChatScreen(),
                  ),
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
