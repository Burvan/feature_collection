import 'package:core/core.dart';
import 'package:feature_collection/src/app/feature_collection_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  runApp(
    const ProviderScope(
      child: FeatureCollectionApp(),
    ),
  );
}
