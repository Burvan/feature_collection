import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

@module
abstract class NavigationModule {
  @singleton
  AppRouter get appRouter => AppRouter();
}