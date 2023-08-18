import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:flutter/material.dart';

class HeaderChatRoom extends StatelessWidget {
  const HeaderChatRoom({
    super.key,
    required this.data,
  });

  final UserDataEntity? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        Expanded(
          child: UserItem(
            user: data!,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            showSubTitile: false,
            photoSize: 40,
            horizontalTitleGap: 8,
          ),
        ),
      ],
    );
  }
}
