library core;

export 'package:cloud_firestore/cloud_firestore.dart' hide Order;
export 'package:easy_localization/easy_localization.dart';
export 'package:firebase_auth/firebase_auth.dart' hide AuthProvider, User;
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:get_it/get_it.dart';
export 'package:injectable/injectable.dart';

export 'src/di/app_di.dart';
export 'src/enums/gender.dart';
export 'src/errors/app_exception.dart';
export 'src/extensions/locale_extension.dart';
export 'src/firebase_options/firebase_options.dart';
export 'src/local_logging/app_logger.dart';
export 'src/localization/localization.dart';
export 'src/utils/validators.dart';

