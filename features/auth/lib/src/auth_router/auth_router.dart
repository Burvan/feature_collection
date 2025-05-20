import 'package:auth/src/ui/sign_in_screen.dart';
import 'package:auth/src/ui/sign_up_screen.dart';
import 'package:auth/src/ui/verification_required_screen.dart';
import 'package:navigation/navigation.dart';

part 'auth_router.gr.dart';

@AutoRouterConfig()
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
