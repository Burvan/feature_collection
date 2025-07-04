import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/src/ui/settings_form.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsForm();
  }
}
