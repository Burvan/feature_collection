import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String fullName;
  final String? avatarUrl;
  final VoidCallback onTap;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  const ChatTile({
    super.key,
    required this.fullName,
    required this.avatarUrl,
    required this.onTap,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.turquoise,
            backgroundImage:
                avatarUrl == null ? null : NetworkImage(avatarUrl ?? ''),
            child: avatarUrl == null
                ? const Icon(
                    Icons.person,
                    color: AppColors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        fullName,
                        style: AppTextTheme.font16.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (lastMessageTime != null)
                      Text(
                        TimeFormatter.formatTime(
                            lastMessageTime ?? DateTime.now()),
                        style: AppTextTheme.font14.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                  ],
                ),
                //const SizedBox(height: 2),
                Text(
                  lastMessage ?? LocaleKeys.chat_startChatting.watchTr(context),
                  style: AppTextTheme.font15.copyWith(
                    color: AppColors.darkGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
