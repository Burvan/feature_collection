import 'package:character_page/character_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';

enum AppFeatures {
  paginationMechanism(CharacterRoute()),
  settings(SettingsRoute());

  final PageRouteInfo route;

  const AppFeatures(this.route);

  String name(BuildContext context) {
    return switch (this) {
      paginationMechanism => LocaleKeys.home_paginationFeature.watchTr(context),
      settings => LocaleKeys.home_settingsFeature.watchTr(context),
    };
  }
}
