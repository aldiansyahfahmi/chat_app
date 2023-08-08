import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class ChatRouter {
  void navigateToAccountScreen();
  void navigateToNewChatScreen();
}

class ChatRouterImpl implements ChatRouter {
  final NavigationHelper navigationHelper;

  ChatRouterImpl({required this.navigationHelper});

  @override
  void navigateToAccountScreen() {
    navigationHelper.pushNamed(AppRoutes.account);
  }

  @override
  void navigateToNewChatScreen() =>
      navigationHelper.pushNamed(AppRoutes.newChat);
}
