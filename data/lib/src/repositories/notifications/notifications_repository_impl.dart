part of repositories;

final class NotificationsRepositoryImpl implements NotificationsRepository {
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    DataConstants.channelId,
    DataConstants.channelName,
    description: DataConstants.channelDescription,
    importance: Importance.max,
    playSound: true,
  );

  final AndroidInitializationSettings _androidSettings =
      const AndroidInitializationSettings(DataConstants.launcherIcon);

  FirebaseMessaging? _fcm;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  Future<bool> get _isFCMSupported => _fcm!.isSupported();

  @override
  Future<void> initialize() async {
    await _initializeRemoteNotifications();
  }

  Future<void> _initializeRemoteNotifications() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _fcm = FirebaseMessaging.instance;

    if (!await _isFCMSupported) return;

    await _initializePlatformSpecific();

    await _flutterLocalNotificationsPlugin?.initialize(
      InitializationSettings(
        android: _androidSettings,
      ),
    );

    FirebaseMessaging.instance.onTokenRefresh.listen(
      (String newToken) async {
        await updateToken();
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (Platform.isIOS) return;

        final RemoteNotification? notification = message.notification;
        if (notification != null) {
          _showNotification(notification);
        }
      },
    );
  }

  Future<void> _initializePlatformSpecific() async {
    try {
      if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin?
            androidFlutterLocalNotificationsPlugin =
            _flutterLocalNotificationsPlugin
                ?.resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>();

        final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        final int androidSdkVersion = androidInfo.version.sdkInt;
        if (androidSdkVersion >= 33) {
          await androidFlutterLocalNotificationsPlugin
              ?.requestNotificationsPermission();
        }
        await androidFlutterLocalNotificationsPlugin
            ?.createNotificationChannel(_androidChannel);
      }
    } on PlatformException catch (e) {
      throw AppException(
        type: AppExceptionType.notificationError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }

  @override
  Future<void> deactivateToken() async {
    assert(
      _fcm != null,
      DataConstants.fcmNotInitializedError,
    );

    if (!await _isFCMSupported) return;


    await _fcm?.deleteToken();
  }

  @override
  Future<String?> getFcmToken() async {
    assert(
      _fcm != null,
      DataConstants.fcmNotInitializedError,
    );

    if (!await _isFCMSupported) return null;
    return _fcm?.getToken();
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    final String? title = notification.title;
    final String? body = notification.body;
    if (title == null || body == null) return;

    await _flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: _androidChannel.importance,
          playSound: _androidChannel.playSound,
          icon: DataConstants.launcherIcon,
        ),
      ),
    );
  }

  @override
  Future<void> updateToken() async {
    try {
      final String? token = await getFcmToken();
      if (token == null) return;

      // await _apiProvider.updateFirebaseToken(
      //   token: token,
      // );
    } on AppException catch (_) {}
  }
}
