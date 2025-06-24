part of 'mappers.dart';

class MapperFactory {
  static UserMapper get userMapper => UserMapper();
  static CharacterMapper get characterMapper => CharacterMapper();
  static ChatMessageMapper get chatMessageMapper => ChatMessageMapper();
  static ChatOverviewMapper get chatOverviewMapper => ChatOverviewMapper();
}
