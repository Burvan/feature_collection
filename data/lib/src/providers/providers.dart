library providers;

import 'dart:ui';

import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/src/entities/chat/chat_message_entity.dart';
import 'package:data/src/entities/chat/chat_overview_entity.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'auth/auth_provider.dart';
part 'firebase/firebase_provider.dart';
part 'local_providers/shared_preferences_provider.dart';
