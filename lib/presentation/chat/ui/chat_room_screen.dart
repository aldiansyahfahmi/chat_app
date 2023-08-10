import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/send_message_bloc/send_message_event.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_cubit.dart';
import 'package:chat_app/presentation/user/bloc/user_by_id_cubit/user_by_id_state.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserDataDto user;
  const ChatRoomScreen({super.key, required this.user});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _messageController = TextEditingController();

  void _getUserById() {
    context.read<UserByIdCubit>().getUserById(
          userId: widget.user.email!,
        );
  }

  @override
  void initState() {
    _getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserByIdCubit, UserByIdState>(
        builder: (context, state) {
          return state.userByIdState.observe(
            (data) => SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const BackButton(),
                      Expanded(
                        child: UserItem(
                          user: widget.user,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          subTitle: false,
                          photoSize: 40,
                          horizontalTitleGap: 8,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade100,
                      padding: const EdgeInsets.all(16),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return const SizedBox();
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                        itemCount: 0,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: ColorName.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _messageController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Tulis pesan...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            context.read<SendMessageBloc>().add(
                                  SendMessage(
                                    sendMessageRequestEntity:
                                        CreateChatRoomRequestEntity(
                                      participants: [
                                        auth.currentUser!.email!,
                                        widget.user.email!,
                                      ],
                                      toEmail: widget.user.email!,
                                      lastMessage: 'Hi',
                                    ),
                                  ),
                                );
                          },
                          child: const Icon(
                            Icons.send,
                            color: ColorName.main,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
