import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class ChatRouter {
  void navigateToAccountScreen();
}

class ChatRouterImpl implements ChatRouter {
  final NavigationHelper navigationHelper;

  ChatRouterImpl({required this.navigationHelper});

  @override
  void navigateToAccountScreen() {
    navigationHelper.pushNamed(AppRoutes.account);
  }
}
