import 'package:chat_app/domains/chat/domain/entities/response/message_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/extensions/date_time_extension.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class MessageCard extends StatelessWidget {
  final MessageDataEntity messageDataEntity;
  MessageCard({super.key, required this.messageDataEntity});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: messageDataEntity.sender == _auth.currentUser!.email
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.60,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: messageDataEntity.sender == _auth.currentUser!.email
                  ? ColorName.main
                  : ColorName.white,
              border: Border.all(color: ColorName.main),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    messageDataEntity.sender == _auth.currentUser!.email
                        ? 8
                        : 0),
                topRight: Radius.circular(
                    messageDataEntity.sender == _auth.currentUser!.email
                        ? 0
                        : 8),
                bottomLeft: const Radius.circular(8),
                bottomRight: const Radius.circular(8),
              ),
            ),
            child: Text(
              messageDataEntity.message,
              style: TextStyle(
                color: messageDataEntity.sender == _auth.currentUser!.email
                    ? ColorName.white
                    : ColorName.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          messageDataEntity.time.toDate().toDateFormatWithTime(),
          style: const TextStyle(
            color: ColorName.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
