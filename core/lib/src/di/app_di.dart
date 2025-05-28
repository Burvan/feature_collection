import 'package:core/core.dart';
import 'package:core/src/di/app_di.config.dart';
import 'package:domain/domain.dart';

final GetIt appLocator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  await $initGetIt(appLocator);
  await appLocator<NotificationsRepository>().initialize();

  ///Only for testing
  final String? token =
      await appLocator<NotificationsRepository>().getFcmToken();
  AppLogger.info(token ?? 'No token');
}
