import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/account/bloc/user_cubit/user_cubit.dart';
import 'package:chat_app/presentation/account/bloc/user_cubit/user_state.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/chat_router.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatRouter _chatRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.userState.observe(
            (data) => SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: GestureDetector(
                        onTap: () => _chatRouter.navigateToAccountScreen(),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorName.main,
                          ),
                          child: data!.photo.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  color: ColorName.white,
                                )
                              : CachedNetworkImage(
                                  imageUrl: data.photo,
                                ),
                        ),
                      ),
                      title: Text(
                        data.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      subtitle: Text(
                        data.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
