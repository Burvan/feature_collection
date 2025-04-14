import 'package:character_page/character_page.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

enum AppFeatures {
  paginationMechanism(
    LocaleKeys.home_paginationFeature,
    CharacterRoute(),
  );

  final String featureName;
  final PageRouteInfo route;

  const AppFeatures(this.featureName, this.route);
}
