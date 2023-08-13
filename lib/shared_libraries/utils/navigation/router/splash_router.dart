import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class SplashRouter {
  void navigateToSignInScreen();
  void navigateToChatScreen();
}

class SplashRouterImpl implements SplashRouter {
  final NavigationHelper navigationHelper;

  SplashRouterImpl({required this.navigationHelper});

  @override
  void navigateToSignInScreen() {
    navigationHelper.pushNamedAndRemoveUntil(AppRoutes.signIn);
  }

  @override
  void navigateToChatScreen() {
    navigationHelper.pushNamedAndRemoveUntil(AppRoutes.chat);
  }
}
