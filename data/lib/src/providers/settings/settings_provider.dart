part of providers;

final class SettingsProvider {
  late final SharedPreferences _prefs;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final ErrorHandler _errorHandler;

  SettingsProvider({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required ErrorHandler errorHandler,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _errorHandler = errorHandler;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveLocale(Locale locale) async {
    await _prefs.setString(
      DataConstants.localeKey,
      '${locale.languageCode}_${locale.countryCode}',
    );
  }

  Locale getLocale() {
    final String localeStr = _prefs.getString(DataConstants.localeKey) ??
        DataConstants.defaultLocale;
    final List<String> parts = localeStr.split('_');

    return Locale(parts[0], parts[1]);
  }

  Future<void> saveTheme(AppTheme theme) async {
    await _prefs.setString(DataConstants.themeKey, theme.name);
  }

  AppTheme getTheme() {
    final String theme =
        _prefs.getString(DataConstants.themeKey) ?? DataConstants.defaultTheme;

    return AppTheme.values.firstWhere(
      (AppTheme appTheme) => appTheme.name == theme,
      orElse: () => AppTheme.system,
    );
  }

  Future<void> deleteAvatar() async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;

      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(user?.uid)
          .update(
        <String, dynamic>{
          DataConstants.avatarKey: FieldValue.delete(),
        },
      );
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> changeAvatar(String avatar) async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;

      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(user?.uid)
          .update(
        <String, dynamic>{
          DataConstants.avatarKey: avatar,
        },
      );
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<String?> getAvatar() async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firebaseFirestore
              .collection(DataConstants.userCollection)
              .doc(user?.uid)
              .get();

      return doc.data()?[DataConstants.avatarKey];
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> changeUserData(LoginPayload payload) async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;

      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(user?.uid)
          .update(
        <String, dynamic>{
          DataConstants.firstNameKey: payload.firstName,
          DataConstants.lastNameKey: payload.lastName,
          DataConstants.emailKey: payload.email,
        },
      );

      if (user?.email != payload.email) {
        await user?.verifyBeforeUpdateEmail(payload.email);
      }
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }
}
