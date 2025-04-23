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
  ) {
    return AuthProvider(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );
  }

  @lazySingleton
  FirebaseProvider firebaseProvider(
    FirebaseFirestore firebaseFirestore,
  ) {
    return FirebaseProvider(firebaseFirestore: firebaseFirestore);
  }

  @lazySingleton
  AuthRepository authRepository(
    AuthProvider authProvider,
  ) {
    return AuthRepositoryImpl(
      authProvider: authProvider,
    );
  }

  @singleton
  NotificationsRepository notificationsRepository() {
    return NotificationsRepositoryImpl();
  }

  @lazySingleton
  CharacterRepository characterRepository(
    FirebaseProvider firebaseProvider,
  ) {
    return CharacterRepositoryImpl(
      firebaseProvider: firebaseProvider,
    );
  }
}
