import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';

import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class ChatRouter {
  void navigateToAccountScreen();
  void navigateToNewChatScreen();
  void navigateToChatRoomScreen({required UserDataEntity userDataEntity});
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
  void navigateToChatRoomScreen({required UserDataEntity userDataEntity}) =>
      navigationHelper.pushNamed(AppRoutes.chatRoom, arguments: userDataEntity);
}
