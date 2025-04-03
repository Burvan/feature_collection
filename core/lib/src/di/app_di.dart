import 'package:core/core.dart';
import 'package:core/src/di/app_di.config.dart';

final GetIt appLocator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(appLocator);
