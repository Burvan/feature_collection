part of extensions;

extension StatusExtension on Status {
  Color get color => switch (this) {
    Status.alive => AppColors.green,
    Status.dead => AppColors.red,
    Status.unknown => AppColors.black,
  };

  String localized(BuildContext context) => switch (this) {
    Status.alive => LocaleKeys.character_alive.watchTr(context),
    Status.dead => LocaleKeys.character_dead.watchTr(context),
    Status.unknown => LocaleKeys.character_unknown.watchTr(context),
  };
}