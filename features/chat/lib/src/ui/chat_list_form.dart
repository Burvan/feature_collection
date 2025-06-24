import 'package:chat/src/bloc/chat_overview_bloc/chat_overview_bloc.dart';
import 'package:chat/src/ui/widgets/app_users_dialog.dart';
import 'package:chat/src/ui/widgets/chat_tile.dart';
import 'package:chat/src/ui/widgets/search_bar.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ChatListForm extends StatelessWidget {
  const ChatListForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.chat_chats.watchTr(
            context,
          ),
          style: AppTextTheme.font17.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ChatSearchBar(),
          ),
          Expanded(
            child: BlocBuilder<ChatOverviewBloc, ChatOverviewState>(
                builder: (_, ChatOverviewState state) {
              return state.isPageLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: state.chats.length,
                      separatorBuilder: (_, __) => const Padding(
                            padding: EdgeInsets.only(left: 80.0),
                            child: Divider(height: 1),
                          ),
                      itemBuilder: (_, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ChatTile(
                            avatarUrl: state.chats[index].avatarUrl,
                            fullName: state.chats[index].fullName,
                            onTap: () {
                              context.read<ChatOverviewBloc>().add(
                                    NavigateToChat(
                                      selectedUserId: state.chats[index].userId,
                                      fullName: state.chats[index].fullName,
                                      avatar: null,
                                    ),
                                  );
                            },
                            lastMessageTime: state.chats[index].lastMessageTime,
                            lastMessage: state.chats[index].lastMessage,
                          ),
                        );
                      });
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AppUsersDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
