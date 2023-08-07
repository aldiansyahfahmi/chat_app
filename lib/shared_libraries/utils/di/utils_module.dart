import 'package:chat_app/shared_libraries/utils/navigation/router/auth_router.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/splash_router.dart';

import '../../../injections/injections.dart';
import '../navigation/navigation_helper.dart';

class RegisterUtilsModule {
  RegisterUtilsModule() {
    _navigations();
    _routers();
  }

  void _navigations() => sl.registerLazySingleton<NavigationHelper>(
        () => NavigationHelperImpl(),
      );

  void _routers() {
    sl.registerLazySingleton<SplashRouter>(
      () => SplashRouterImpl(
        navigationHelper: sl(),
      ),
    );
    sl.registerLazySingleton<AuthRouter>(
      () => AuthRouterImpl(
        navigationHelper: sl(),
      ),
    );
  }
}
