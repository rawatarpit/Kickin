import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  bool hasUuid() => _uuid != null;

  // "is_group" field.
  bool? _isGroup;
  bool get isGroup => _isGroup ?? false;
  bool hasIsGroup() => _isGroup != null;

  // "is_read" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  bool hasIsRead() => _isRead != null;

  // "group_name" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "group_image" field.
  String? _groupImage;
  String get groupImage => _groupImage ?? '';
  bool hasGroupImage() => _groupImage != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "participant_id" field.
  List<String>? _participantId;
  List<String> get participantId => _participantId ?? const [];
  bool hasParticipantId() => _participantId != null;

  void _initializeFields() {
    _uuid = snapshotData['uuid'] as String?;
    _isGroup = snapshotData['is_group'] as bool?;
    _isRead = snapshotData['is_read'] as bool?;
    _groupName = snapshotData['group_name'] as String?;
    _groupImage = snapshotData['group_image'] as String?;
    _lastMessage = snapshotData['last_message'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _participantId = getDataList(snapshotData['participant_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  String? uuid,
  bool? isGroup,
  bool? isRead,
  String? groupName,
  String? groupImage,
  String? lastMessage,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uuid': uuid,
      'is_group': isGroup,
      'is_read': isRead,
      'group_name': groupName,
      'group_image': groupImage,
      'last_message': lastMessage,
      'created_at': createdAt,
      'updated_at': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.uuid == e2?.uuid &&
        e1?.isGroup == e2?.isGroup &&
        e1?.isRead == e2?.isRead &&
        e1?.groupName == e2?.groupName &&
        e1?.groupImage == e2?.groupImage &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        listEquality.equals(e1?.participantId, e2?.participantId);
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.uuid,
        e?.isGroup,
        e?.isRead,
        e?.groupName,
        e?.groupImage,
        e?.lastMessage,
        e?.createdAt,
        e?.updatedAt,
        e?.participantId
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
