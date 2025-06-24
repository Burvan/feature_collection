import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

@module
abstract class DataModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @preResolve
  Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();

  @lazySingleton
  ErrorHandler get errorHandler => ErrorHandler();

  @lazySingleton
  AuthProvider authProvider() {
    return AuthProvider(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      errorHandler: errorHandler,
    );
  }

  @lazySingleton
  FirebaseProvider firebaseProvider() {
    return FirebaseProvider(
      firebaseFirestore: firebaseFirestore,
      firebaseAuth: firebaseAuth,
      errorHandler: errorHandler,
    );
  }

  @preResolve
  Future<SharedPreferencesProvider> sharedPreferencesProvider() async {
    return SharedPreferencesProvider(prefs: await prefs);
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

  @lazySingleton
  SettingsRepository settingsRepository(
    SharedPreferencesProvider sharedPreferencesProvider,
    FirebaseProvider firebaseProvider,
  ) {
    return SettingsRepositoryImpl(
      sharedPreferencesProvider: sharedPreferencesProvider,
      firebaseProvider: firebaseProvider,
    );
  }

  @lazySingleton
  ChatRepository chatRepository(
    FirebaseProvider firebaseProvider,
  ) {
    return ChatRepositoryImpl(
      firebaseProvider: firebaseProvider,
    );
  }
}
