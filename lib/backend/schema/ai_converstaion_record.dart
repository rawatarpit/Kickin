import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AiConverstaionRecord extends FirestoreRecord {
  AiConverstaionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _message = snapshotData['message'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ai_converstaion');

  static Stream<AiConverstaionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AiConverstaionRecord.fromSnapshot(s));

  static Future<AiConverstaionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AiConverstaionRecord.fromSnapshot(s));

  static AiConverstaionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AiConverstaionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AiConverstaionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AiConverstaionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AiConverstaionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AiConverstaionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAiConverstaionRecordData({
  String? id,
  DocumentReference? userId,
  String? message,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'user_id': userId,
      'message': message,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class AiConverstaionRecordDocumentEquality
    implements Equality<AiConverstaionRecord> {
  const AiConverstaionRecordDocumentEquality();

  @override
  bool equals(AiConverstaionRecord? e1, AiConverstaionRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.userId == e2?.userId &&
        e1?.message == e2?.message &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(AiConverstaionRecord? e) =>
      const ListEquality().hash([e?.id, e?.userId, e?.message, e?.createdTime]);

  @override
  bool isValidKey(Object? o) => o is AiConverstaionRecord;
}
