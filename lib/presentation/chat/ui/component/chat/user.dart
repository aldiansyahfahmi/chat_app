import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/presentation/user/bloc/profile_cubit/profile_cubit.dart';
import 'package:chat_app/presentation/user/bloc/profile_cubit/profile_state.dart';
import 'package:chat_app/shared_libraries/component/item/user_item.dart';
import 'package:chat_app/shared_libraries/utils/navigation/router/chat_router.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User extends StatelessWidget {
  User({super.key});

  final ChatRouter _chatRouter = sl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return state.profileState.observe(
          (dataStream) => StreamBuilder(
            stream: dataStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data;
              return UserItem(
                contentPadding: EdgeInsets.zero,
                onTap: () => _chatRouter.navigateToAccountScreen(),
                user: data!,
              );
            },
          ),
        );
      },
    );
  }
}
