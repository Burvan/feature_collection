import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/src/ui/edit_profile_screen.dart';
import 'package:settings_page/src/ui/settings_screen.dart';

part 'settings_router.gr.dart';

@AutoRouterConfig()
class SettingsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
