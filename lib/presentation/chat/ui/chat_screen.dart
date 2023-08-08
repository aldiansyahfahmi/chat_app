import 'package:chat_app/presentation/account/bloc/user_cubit/user_cubit.dart';
import 'package:chat_app/presentation/account/bloc/user_cubit/user_state.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.userState.observe(
            (data) => Center(
              child: Text(data!.username),
            ),
          );
        },
      ),
    );
  }
}
