import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

@module
abstract class DataModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @lazySingleton
  AuthProvider authProvider(
    FirebaseAuth firebaseAuth,
    FirebaseFirestore firebaseFirestore,
  ) =>
      AuthProvider(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
      );

  @lazySingleton
  AuthRepository authRepository(
    AuthProvider authProvider,
  ) =>
      AuthRepositoryImpl(
        authProvider: authProvider,
      );

  @singleton
  NotificationsRepository notificationsRepository() =>
      NotificationsRepositoryImpl();
}
