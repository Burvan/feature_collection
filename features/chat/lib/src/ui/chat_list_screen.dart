import 'package:chat/src/bloc/chat_overview_bloc/chat_overview_bloc.dart';
import 'package:chat/src/ui/chat_list_form.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatOverviewBloc>(
      create: (_) => ChatOverviewBloc(
        fetchChatOverviewsUseCase: appLocator.get<FetchChatOverviewsUseCase>(),
        fetchCurrentUserUseCase: appLocator.get<FetchCurrentUserUseCase>(),
        appRouter: appLocator.get<AppRouter>(),
      ),
      child: const ChatListForm(),
    );
  }
}
