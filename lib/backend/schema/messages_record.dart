import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends FirestoreRecord {
  MessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sender_id" field.
  DocumentReference? _senderId;
  DocumentReference? get senderId => _senderId;
  bool hasSenderId() => _senderId != null;

  // "uuid" field.
  String? _uuid;
  String get uuid => _uuid ?? '';
  bool hasUuid() => _uuid != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "is_read" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  bool hasIsRead() => _isRead != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "post_id" field.
  DocumentReference? _postId;
  DocumentReference? get postId => _postId;
  bool hasPostId() => _postId != null;

  // "media" field.
  List<String>? _media;
  List<String> get media => _media ?? const [];
  bool hasMedia() => _media != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _senderId = snapshotData['sender_id'] as DocumentReference?;
    _uuid = snapshotData['uuid'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _isRead = snapshotData['is_read'] as bool?;
    _text = snapshotData['text'] as String?;
    _type = snapshotData['type'] as String?;
    _postId = snapshotData['post_id'] as DocumentReference?;
    _media = getDataList(snapshotData['media']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('messages')
          : FirebaseFirestore.instance.collectionGroup('messages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('messages').doc(id);

  static Stream<MessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessagesRecordData({
  DocumentReference? senderId,
  String? uuid,
  DateTime? createdAt,
  DateTime? updatedAt,
  bool? isRead,
  String? text,
  String? type,
  DocumentReference? postId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sender_id': senderId,
      'uuid': uuid,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_read': isRead,
      'text': text,
      'type': type,
      'post_id': postId,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.senderId == e2?.senderId &&
        e1?.uuid == e2?.uuid &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.isRead == e2?.isRead &&
        e1?.text == e2?.text &&
        e1?.type == e2?.type &&
        e1?.postId == e2?.postId &&
        listEquality.equals(e1?.media, e2?.media);
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality().hash([
        e?.senderId,
        e?.uuid,
        e?.createdAt,
        e?.updatedAt,
        e?.isRead,
        e?.text,
        e?.type,
        e?.postId,
        e?.media
      ]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}
