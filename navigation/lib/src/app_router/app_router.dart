import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:character_page/character_page.dart';
import 'package:home_page/home_page.dart';
import 'package:settings_page/settings_page.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: SignInRoute.page,
          initial: true,
        ),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: VerificationRequiredRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CharacterRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: EditProfileRoute.page),
      ];
}
