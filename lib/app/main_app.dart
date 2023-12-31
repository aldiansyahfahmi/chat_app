import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/auth/bloc/photo_picker_cubit/photo_picker_cubit.dart';
import 'package:chat_app/presentation/auth/bloc/upload_photo_bloc/upload_photo_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/messages_cubit/messages_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/my_chat_with_cubit/my_chat_with_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/my_chats_cubit/my_chats_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:chat_app/presentation/user/bloc/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/presentation/chat/ui/chat_room_screen.dart';
import 'package:chat_app/presentation/user/bloc/profile_cubit/profile_cubit.dart';
import 'package:chat_app/presentation/user/bloc/sign_out_cubit/sign_out_cubit.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_cubit.dart';
import 'package:chat_app/presentation/user/ui/account_screen.dart';
import 'package:chat_app/presentation/auth/bloc/sign_in_with_email_and_password_bloc/sign_in_with_email_and_password_bloc.dart';
import 'package:chat_app/presentation/auth/bloc/sign_up_with_email_and_password_bloc/sign_up_with_email_and_password_bloc.dart';
import 'package:chat_app/presentation/auth/ui/sign_in_screen.dart';
import 'package:chat_app/presentation/auth/ui/sign_up_screen.dart';
import 'package:chat_app/presentation/chat/ui/chat_screen.dart';
import 'package:chat_app/presentation/chat/ui/new_chat_screen.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit/splash_cubit.dart';
import 'package:chat_app/presentation/splash/ui/splash_screen.dart';
import 'package:chat_app/shared_libraries/utils/navigation/arguments/chat_room_argument.dart';
import 'package:chat_app/shared_libraries/utils/resources/fonts.gen.dart';
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
            fontFamily: FontFamily.nunito,
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
            final arguments = settings.arguments;
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
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => SignUpWithEmailAndPasswordBloc(
                          signUpWithEmailAndPasswordUseCase: sl(),
                          uploadPhotoUseCase: sl(),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => PhotoPickerCubit(),
                      ),
                      BlocProvider(
                        create: (context) => UploadPhotoBloc(
                          uploadPhotoUseCase: sl(),
                        ),
                      ),
                    ],
                    child: SignUpScreen(),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.chat:
                return PageTransition(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ProfileCubit(
                          getProfileUseCase: sl(),
                        )..getProfile(),
                      ),
                      BlocProvider(
                        create: (context) => MyChatsCubit(
                          getMyChatsUseCase: sl(),
                        )..getMyChats(),
                      ),
                      BlocProvider(
                        create: (context) => UserByIdCubit(
                          getUserByIdUseCase: sl(),
                        ),
                      ),
                    ],
                    child: ChatScreen(),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.account:
                return PageTransition(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ProfileCubit(
                          getProfileUseCase: sl(),
                        )..getProfile(),
                      ),
                      BlocProvider(
                        create: (context) => SignOutCubit(
                          getSignOutUseCase: sl(),
                        ),
                      ),
                    ],
                    child: AccountScreen(),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.newChat:
                return PageTransition(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => AllUsersCubit(
                          getAllUsersUseCase: sl(),
                        )..getAllUsers(),
                      ),
                      BlocProvider(
                        create: (context) => MyChatWithCubit(
                          getMyChatWithUseCase: sl(),
                        ),
                      ),
                    ],
                    child: NewChatScreen(),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              case AppRoutes.chatRoom:
                return PageTransition(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => UserByIdCubit(
                          getUserByIdUseCase: sl(),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => SendMessageBloc(
                          sendMessageUseCase: sl(),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => MessagesCubit(
                          getMessagesUseCase: sl(),
                        ),
                      ),
                    ],
                    child: ChatRoomScreen(
                      argument: arguments as ChatRoomArgument,
                    ),
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
