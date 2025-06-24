import 'dart:typed_data';

import 'package:chat/src/bloc/chat_with_user_bloc/chat_with_user_bloc.dart';
import 'package:chat/src/ui/chat_form.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  final String chatId;
  final String otherUserId;
  final String fullName;
  final Uint8List? avatar;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.fullName,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatWithUserBloc>(
      create: (_) => ChatWithUserBloc(
        fetchRecentMessagesUseCase:
            appLocator.get<FetchRecentMessagesUseCase>(),
        fetchOldMessagesUseCase: appLocator.get<FetchOldMessagesUseCase>(),
        sendMessageUseCase: appLocator.get<SendMessageUseCase>(),
        fetchCurrentUserUseCase: appLocator.get<FetchCurrentUserUseCase>(),
        otherUserId: otherUserId,
        fullName: fullName,
        avatar: avatar,
      ),
      child: const ChatForm(),
    );
  }
}
