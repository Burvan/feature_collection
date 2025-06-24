part of providers;

final class FirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final ErrorHandler _errorHandler;

  const FirebaseProvider({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required ErrorHandler errorHandler,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth,
        _errorHandler = errorHandler;

  Future<List<CharacterEntity>> fetchCharacters(
    PaginationPayload params,
  ) async {
    try {
      Query<Map<String, dynamic>> queryRef = _firebaseFirestore
          .collection(DataConstants.characterCollection)
          .orderBy(DataConstants.name)
          .limit(params.limit);

      if (params.paginationCursor != null) {
        final DocumentSnapshot<Map<String, dynamic>> lastDoc =
            await _firebaseFirestore
                .doc(
                  '${DataConstants.characterCollection}/${params.paginationCursor}',
                )
                .get();
        queryRef = queryRef.startAfterDocument(lastDoc);
      }

      if (params.query != null) {
        queryRef = queryRef
            .where(DataConstants.name, isGreaterThanOrEqualTo: params.query)
            .where(DataConstants.name, isLessThan: '${params.query}z');
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await queryRef.get();

      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        if (!data.containsKey(DataConstants.idKey)) {
          data[DataConstants.idKey] = int.parse(doc.id);
        }
        return CharacterEntity.fromJson(data);
      }).toList();
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> addCharacter(CharacterEntity entity) async {
    try {
      await _firebaseFirestore
          .collection(DataConstants.characterCollection)
          .add(entity.toJson());
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<UserEntity> fetchCurrentUser() async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firebaseFirestore
              .collection(DataConstants.userCollection)
              .doc(user?.uid)
              .get();

      final UserEntity entity = UserEntity.fromJson(doc.data()!);

      return entity;
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> changeUserData(User user) async {
    try {
      final UserEntity entity = MapperFactory.userMapper.toEntity(user);
      final firebase_auth.User? currentUser = _firebaseAuth.currentUser;

      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(currentUser?.uid)
          .update(entity.toJson());

      if (currentUser?.email != entity.email) {
        await currentUser?.verifyBeforeUpdateEmail(entity.email);
      }
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<bool> checkEmailConsistency() async {
    final firebase_auth.User? user = _firebaseAuth.currentUser;

    final DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseFirestore
        .collection(DataConstants.userCollection)
        .doc(user?.uid)
        .get();

    final String storedEmail = doc.data()?[DataConstants.emailKey];

    return user?.email == storedEmail;
  }

  Future<void> sendMessage(ChatMessageEntity message) async {
    try {
      final String chatId =
          _generateChatId(message.senderId, message.receiverId);

      await _firebaseFirestore
          .collection(DataConstants.chatCollection)
          .doc(chatId)
          .collection(DataConstants.messageCollection)
          .add(message.toJson());

      await _updateChatOverview(
        userId: message.senderId,
        otherUserId: message.receiverId,
        lastMessage: message.text,
        lastMessageTime: message.timestamp,
      );

      await _updateChatOverview(
        userId: message.receiverId,
        otherUserId: message.senderId,
        lastMessage: message.text,
        lastMessageTime: message.timestamp,
      );
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Stream<List<ChatMessageEntity>> fetchRecentMessages(
    ChatWithUserPayload payload,
  ) {
    try {
      final String chatId = _generateChatId(
        payload.currentUserId,
        payload.otherUserId,
      );

      final Query<Map<String, dynamic>> collectionRef = _firebaseFirestore
          .collection(DataConstants.chatCollection)
          .doc(chatId)
          .collection(DataConstants.messageCollection)
          .orderBy(DataConstants.messageTimestampKey, descending: true)
          .limit(payload.paginationPayload.limit);

      if (payload.paginationPayload.paginationCursor == null) {
        return collectionRef.snapshots().map(
          (QuerySnapshot<Map<String, dynamic>> snapshot) {
            return snapshot.docs.map(
              (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
                final ChatMessageEntity data = ChatMessageEntity.fromJson(
                  doc.data(),
                );

                return ChatMessageEntity(
                  id: doc.id,
                  senderId: data.senderId,
                  receiverId: data.receiverId,
                  text: data.text,
                  timestamp: data.timestamp,
                );
              },
            ).toList();
          },
        );
      }

      final DocumentReference<Map<String, dynamic>> lastDocRef =
          _firebaseFirestore
              .collection(DataConstants.chatCollection)
              .doc(chatId)
              .collection(DataConstants.messageCollection)
              .doc(payload.paginationPayload.paginationCursor);

      return lastDocRef.get().asStream().asyncExpand((
        DocumentSnapshot<Map<String, dynamic>> lastDoc,
      ) {
        final Query<Map<String, dynamic>> pagedQuery =
            collectionRef.startAfterDocument(lastDoc);

        return pagedQuery.snapshots().map(
          (QuerySnapshot<Map<String, dynamic>> snapshot) {
            return snapshot.docs.map(
              (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
                final ChatMessageEntity data = ChatMessageEntity.fromJson(
                  doc.data(),
                );

                return ChatMessageEntity(
                  id: doc.id,
                  senderId: data.senderId,
                  receiverId: data.receiverId,
                  text: data.text,
                  timestamp: data.timestamp,
                );
              },
            ).toList();
          },
        );
      });
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<List<ChatMessageEntity>> fetchOldMessages(
      ChatWithUserPayload payload) async {
    try {
      final String chatId = _generateChatId(
        payload.currentUserId,
        payload.otherUserId,
      );

      Query<Map<String, dynamic>> query = _firebaseFirestore
          .collection(DataConstants.chatCollection)
          .doc(chatId)
          .collection(DataConstants.messageCollection)
          .orderBy(DataConstants.messageTimestampKey, descending: true)
          .limit(payload.paginationPayload.limit);

      if (payload.paginationPayload.paginationCursor != null) {
        final DocumentSnapshot<Map<String, dynamic>> lastDoc =
            await _firebaseFirestore
                .collection(DataConstants.chatCollection)
                .doc(chatId)
                .collection(DataConstants.messageCollection)
                .doc(payload.paginationPayload.paginationCursor)
                .get();

        query = query.startAfterDocument(lastDoc);
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();

      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final ChatMessageEntity data = ChatMessageEntity.fromJson(doc.data());

        return ChatMessageEntity(
          id: doc.id,
          senderId: data.senderId,
          receiverId: data.receiverId,
          text: data.text,
          timestamp: data.timestamp,
        );
      }).toList();
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Stream<List<ChatOverviewEntity>> fetchChatOverviews(
      ChatOverviewPayload payload) async* {
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> chatOverviewsStream =
          _firebaseFirestore
              .collection(DataConstants.userCollection)
              .doc(payload.currentUserId)
              .collection(DataConstants.chatOverviewCollection)
              .snapshots();

      await for (final QuerySnapshot<Map<String, dynamic>> snapshot
          in chatOverviewsStream) {
        final List<ChatOverviewEntity> chats = snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
          final Map<String, dynamic> data = doc.data();
          AppLogger.info(data.toString());
          return ChatOverviewEntity.fromJson(data);
        }).toList();

        chats.sort((ChatOverviewEntity a, ChatOverviewEntity b) {
          final DateTime? aTime = a.lastMessageTimeKey;
          final DateTime? bTime = b.lastMessageTimeKey;

          if (aTime == null && bTime == null) return 0;
          if (aTime == null) return 1;
          if (bTime == null) return -1;
          return bTime.compareTo(aTime);
        });

        yield chats;
      }
    } catch (e) {
      AppLogger.error(e.toString());
      _errorHandler.handleError(e);
    }
  }

  Future<List<UserEntity>> fetchUsers(PaginationPayload<String> payload) async {
    try {
      Query<Map<String, dynamic>> query = _firebaseFirestore
          .collection(DataConstants.userCollection)
          .orderBy(DataConstants.firstNameKey)
          .limit(payload.limit);

      if (payload.paginationCursor != null) {
        final DocumentSnapshot<Map<String, dynamic>> lastDoc =
            await _firebaseFirestore
                .collection(DataConstants.userCollection)
                .doc(payload.paginationCursor)
                .get();

        query = query.startAfterDocument(lastDoc);
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();

      final String? currentUserId = _firebaseAuth.currentUser?.uid;

      return snapshot.docs
          .where((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              doc.id != currentUserId)
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              UserEntity.fromJson(doc.data()))
          .toList();
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> _updateChatOverview({
    required String userId,
    required String otherUserId,
    required String lastMessage,
    required DateTime lastMessageTime,
  }) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firebaseFirestore
              .collection(DataConstants.userCollection)
              .doc(otherUserId)
              .get();

      final String firstName = userDoc[DataConstants.firstNameKey];
      final String lastName = userDoc[DataConstants.lastNameKey];
      final String fullName = '$firstName $lastName'.trim();

      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(userId)
          .collection(DataConstants.chatOverviewCollection)
          .doc(otherUserId)
          .set(
        <String, dynamic>{
          DataConstants.idKey: otherUserId,
          DataConstants.fullNameKey: fullName,
          DataConstants.avatarKey: userDoc[DataConstants.avatarKey],
          DataConstants.lastMessageKey: lastMessage,
          DataConstants.lastMessageTimeKey: lastMessageTime,
        },
      );
    } catch (e) {
      AppLogger.error(e.toString());
      _errorHandler.handleError(e);
    }
  }

  String _generateChatId(String a, String b) {
    final List<String> sorted = <String>[a, b]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }
}
