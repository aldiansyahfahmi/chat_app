import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class AuthRouter {
  void navigateToSignUpScreen();
  void navigateToChatScreen();
}

class AuthRouterImpl implements AuthRouter {
  final NavigationHelper navigationHelper;

  AuthRouterImpl({required this.navigationHelper});

  @override
  void navigateToSignUpScreen() {
    navigationHelper.pushNamed(AppRoutes.signUp);
  }

  @override
  void navigateToChatScreen() {
    navigationHelper.pushNamedAndRemoveUntil(AppRoutes.chat);
  }
}
