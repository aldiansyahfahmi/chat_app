import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/chat/ui/component/chat/my_chats.dart';
import 'package:chat_app/presentation/chat/ui/component/chat/user.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/chat_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatRouter _chatRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorName.main,
        elevation: 0,
        onPressed: () => _chatRouter.navigateToNewChatScreen(),
        child: const Icon(
          Icons.chat,
          color: ColorName.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              User(),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Chat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              MyChats(),
            ],
          ),
        ),
      ),
    );
  }
}
