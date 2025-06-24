import 'dart:typed_data';

import 'package:chat/src/ui/chat_list_screen.dart';
import 'package:chat/src/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

part 'chat_router.gr.dart';

@AutoRouterConfig()
class ChatRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
