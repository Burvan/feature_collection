library core;

export 'src/di/app_di.dart';
export 'src/local_logging/app_logger.dart';
export 'src/firebase_options/firebase_options.dart';
export 'src/errors/errors.dart';

export 'package:injectable/injectable.dart';
export 'package:get_it/get_it.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart' hide AuthProvider, User;
export 'package:cloud_firestore/cloud_firestore.dart' hide Order;

