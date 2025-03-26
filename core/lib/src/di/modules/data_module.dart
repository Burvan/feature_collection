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
  MapperFactory get mapperFactory => MapperFactory();

  @lazySingleton
  AuthErrorHandler get authErrorHandler => AuthErrorHandler();

  @lazySingleton
  AuthProvider authProvider(
      FirebaseAuth firebaseAuth,
      FirebaseFirestore firebaseFirestore,
      AuthErrorHandler errorHandler,
      ) =>
      AuthProvider(
        firebaseAuth: firebaseAuth,
        firebaseFirestore: firebaseFirestore,
        errorHandler: errorHandler,
      );

  @lazySingleton
  AuthRepository authRepository(
      MapperFactory mapper,
      AuthProvider authProvider,
      ) =>
      AuthRepositoryImpl(
        authProvider: authProvider,
        mapper: mapper,
      );
}
