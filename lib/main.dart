import 'package:core/core.dart';
import 'package:feature_collection/app/feature_collection_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const FeatureCollectionApp());
}
