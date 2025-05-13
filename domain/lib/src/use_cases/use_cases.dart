library use_cases;

import 'dart:typed_data';
import 'dart:ui';

import 'package:domain/domain.dart';

part 'auth/sign_in_use_case.dart';
part 'auth/sign_out_use_case.dart';
part 'auth/sign_up_use_case.dart';

part 'character/add_character_use_case.dart';
part 'character/fetch_characters_use_case.dart';

part 'settings/change_avatar_use_case.dart';
part 'settings/change_locale_use_case.dart';
part 'settings/change_theme_use_case.dart';
part 'settings/change_user_data_use_case.dart';
part 'settings/delete_avatar_use_case.dart';
part 'settings/get_avatar_use_case.dart';
part 'settings/get_current_locale_use_case.dart';
part 'settings/get_current_theme_use_case.dart';
part 'use_case.dart';