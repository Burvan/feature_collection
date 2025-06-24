import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isMine;
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.isMine,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isMine ? AppColors.lightGreen : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.25,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                message.text,
                style: AppTextTheme.font17.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat.Hm().format(message.timestamp),
              style: AppTextTheme.font11.copyWith(
                color: isMine ? AppColors.green : AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
