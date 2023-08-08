import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';

import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class ChatRouter {
  void navigateToAccountScreen();
  void navigateToNewChatScreen();
  void navigateToChatRoomScreen({required UserDataDto userDataDto});
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
  void navigateToChatRoomScreen({required UserDataDto userDataDto}) =>
      navigationHelper.pushNamed(AppRoutes.chatRoom, arguments: userDataDto);
}
