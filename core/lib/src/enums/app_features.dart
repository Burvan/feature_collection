import 'package:character_page/character_page.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';

enum AppFeatures {
  paginationMechanism(
    LocaleKeys.home_paginationFeature,
    CharacterRoute(),
  ),

  settings(
    LocaleKeys.home_settingsFeature,
    SettingsRoute(),
  );

  final String featureName;
  final PageRouteInfo route;

  const AppFeatures(this.featureName, this.route);
}
