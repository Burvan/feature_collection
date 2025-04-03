import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:home_page/home_page.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: SignInRoute.page,
          initial: true,
        ),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
