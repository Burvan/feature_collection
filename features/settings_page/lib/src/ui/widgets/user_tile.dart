import 'dart:typed_data';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final VoidCallback onAvatarTap;
  final Uint8List? avatar;

  const UserTile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.onAvatarTap,
    required this.avatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData themeData = Theme.of(context);

    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: onAvatarTap,
          child: Hero(
            tag: id,
            child: CircleAvatar(
              radius: size.width / 6,
              backgroundColor: themeData.primaryColor,
              backgroundImage: avatar != null ? MemoryImage(avatar!) : null,
              child: avatar == null
                  ? const Icon(
                      Icons.add_a_photo,
                      size: 30,
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstName,
                style: AppTextTheme.font18,
              ),
              Text(
                lastName,
                style: AppTextTheme.font18,
              ),
              Text(
                email,
                style: AppTextTheme.font18,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
