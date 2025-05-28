import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final Character character;

  const CharacterTile({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 16,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: themeData.cardColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 12,
              color: themeData.highlightColor,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: character.imagePath,
              fit: BoxFit.cover,
              height: size.height / 5,
              width: size.width / 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      character.name,
                      style: AppTextTheme.font25Bold,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: character.status.color,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          character.status.localized(context),
                          style: AppTextTheme.font18Bold,
                        ),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: LocaleKeys.character_characterTileHouse
                                .watchTr(context),
                            style: AppTextTheme.font18Bold.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          TextSpan(
                            text: character.house ??
                                LocaleKeys.character_notHogwartsStudent
                                    .watchTr(context),
                            style: AppTextTheme.font18Bold,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      character.description,
                      style: AppTextTheme.font16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
