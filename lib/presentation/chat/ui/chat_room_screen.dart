import 'package:chat_app/presentation/chat/bloc/messages_cubit/messages_cubit.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_state.dart';
import 'package:chat_app/presentation/chat/ui/component/chat_room/body_chat_room.dart';
import 'package:chat_app/presentation/chat/ui/component/chat_room/footer_chat_room.dart';
import 'package:chat_app/presentation/chat/ui/component/chat_room/header_chat_room.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_cubit.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_state.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:chat_app/shared_libraries/utils/navigation/arguments/chat_room_argument.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoomArgument argument;
  const ChatRoomScreen({super.key, required this.argument});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _scrollController = ScrollController();

  void _getUserById() {
    context.read<UserByIdCubit>().getUserById(
          userId: widget.argument.userDataEntity.email,
        );
  }

  void _getMessages({String? chatId}) {
    context.read<MessagesCubit>().getMessages(
          chatId: widget.argument.chatId.isNotEmpty
              ? widget.argument.chatId
              : chatId!,
        );
  }

  @override
  void initState() {
    _getUserById();
    if (widget.argument.chatId.isNotEmpty) {
      _getMessages();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SendMessageBloc, SendMessageState>(
        listener: (context, state) {
          final status = state.sendMessageState.status;

          if (status.isHasData) {
            final FirestoreService firestoreService = FirestoreService();
            firestoreService.usersCollection
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection(AppConstants.appCollection.chats)
                .where('chat_with',
                    isEqualTo: widget.argument.userDataEntity.email)
                .get()
                .then(
              (chat) async {
                _getMessages(chatId: chat.docs.first.id);
              },
            );
          }
        },
        child: BlocBuilder<UserByIdCubit, UserByIdState>(
          builder: (context, state) {
            return state.userByIdState.observe(
              (dataStream) => StreamBuilder(
                stream: dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return SafeArea(
                      child: Column(
                        children: [
                          HeaderChatRoom(data: data),
                          BodyChatRoom(scrollController: _scrollController),
                          FooterChatRoom(argument: widget.argument)
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
