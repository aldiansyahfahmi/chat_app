import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class AccountRouter {
  void navigateToSignInScreen();
}

class AccountRouterImpl implements AccountRouter {
  final NavigationHelper navigationHelper;

  AccountRouterImpl({required this.navigationHelper});

  @override
  void navigateToSignInScreen() {
    navigationHelper.pushNamedAndRemoveUntil(AppRoutes.signIn);
  }
}
