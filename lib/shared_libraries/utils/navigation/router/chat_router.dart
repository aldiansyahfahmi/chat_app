import 'package:chat_app/shared_libraries/utils/navigation/arguments/chat_room_argument.dart';

import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class ChatRouter {
  void navigateToAccountScreen();
  void navigateToNewChatScreen();
  void navigateToChatRoomScreen({required ChatRoomArgument argument});
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

  @override
  void navigateToChatRoomScreen({required ChatRoomArgument argument}) =>
      navigationHelper.pushNamed(
        AppRoutes.chatRoom,
        arguments: argument,
      );
}
