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
    return Padding(
      padding: const EdgeInsets.all(AppPadding.padding10),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius18),
          color: AppColors.lightGrey,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: AppBorderRadius.borderRadius12,
              color: AppColors.black,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CharacterImage(imagePath: character.imagePath),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.padding10),
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
                          size: AppSize.size10,
                          color: character.status ==
                                  LocaleKeys.character_alive.watchTr(context)
                              ? AppColors.green
                              : (character.status ==
                                      LocaleKeys.character_dead.watchTr(context)
                                  ? AppColors.red
                                  : AppColors.black),
                        ),
                        const SizedBox(width: AppSize.size2),
                        Text(
                          character.status,
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
