abstract interface class NotificationsRepository {
  Future<void> initialize();
  Future<String?> getFcmToken();
  Future<void> deactivateToken();
  Future<void> updateToken();
}