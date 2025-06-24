import 'package:chat/src/bloc/chat_with_user_bloc/chat_with_user_bloc.dart';
import 'package:chat/src/ui/widgets/chat_bubble.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ChatForm extends StatefulWidget {
  const ChatForm({super.key});

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final ChatWithUserBloc bloc = context.read<ChatWithUserBloc>();

    _scrollController.addListener(
      () {
        if (!bloc.state.isEndOfList &&
            !bloc.state.isMessagesLoading &&
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent *
                    bloc.state.triggerOffset) {
          bloc.add(const LoadMore());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatWithUserBloc bloc = context.read<ChatWithUserBloc>();

    return BlocBuilder<ChatWithUserBloc, ChatWithUserState>(
      builder: (BuildContext context, ChatWithUserState state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              bloc.fullName,
              style: AppTextTheme.font17.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.turquoise,
                  backgroundImage:
                      bloc.avatar != null ? MemoryImage(bloc.avatar!) : null,
                  child: bloc.avatar == null
                      ? const Icon(
                          Icons.person,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: BlocBuilder<ChatWithUserBloc, ChatWithUserState>(
                  builder: (BuildContext context, ChatWithUserState state) {
                    return state.isPageLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListView.builder(
                              controller: _scrollController,
                              reverse: true,
                              itemCount: state.messages.length +
                                  (state.isEndOfList ? 0 : 1),
                              itemBuilder: (_, int index) {
                                if (index == state.messages.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return ChatBubble(
                                  isMine: state.messages[index].senderId !=
                                      bloc.otherUserId,
                                  message: state.messages[index],
                                );
                              },
                            ),
                          );
                  },
                ),
              ),
              SafeArea(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                      ),
                    ),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 4,
                        ),
                        child: TextField(
                          minLines: 1,
                          maxLines: 6,
                          controller: _messageController,
                          style: AppTextTheme.font16.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            hintText: LocaleKeys.chat_message.watchTr(context),
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          bloc.add(
                            SendMessage(text: _messageController.text),
                          );
                          _messageController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
