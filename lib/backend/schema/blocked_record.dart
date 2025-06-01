import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BlockedRecord extends FirestoreRecord {
  BlockedRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "by_currentUser" field.
  bool? _byCurrentUser;
  bool get byCurrentUser => _byCurrentUser ?? false;
  bool hasByCurrentUser() => _byCurrentUser != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as DocumentReference?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _byCurrentUser = snapshotData['by_currentUser'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('blocked')
          : FirebaseFirestore.instance.collectionGroup('blocked');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('blocked').doc(id);

  static Stream<BlockedRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BlockedRecord.fromSnapshot(s));

  static Future<BlockedRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BlockedRecord.fromSnapshot(s));

  static BlockedRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BlockedRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BlockedRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BlockedRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BlockedRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BlockedRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBlockedRecordData({
  DocumentReference? userId,
  DateTime? timestamp,
  bool? byCurrentUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'timestamp': timestamp,
      'by_currentUser': byCurrentUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class BlockedRecordDocumentEquality implements Equality<BlockedRecord> {
  const BlockedRecordDocumentEquality();

  @override
  bool equals(BlockedRecord? e1, BlockedRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.timestamp == e2?.timestamp &&
        e1?.byCurrentUser == e2?.byCurrentUser;
  }

  @override
  int hash(BlockedRecord? e) =>
      const ListEquality().hash([e?.userId, e?.timestamp, e?.byCurrentUser]);

  @override
  bool isValidKey(Object? o) => o is BlockedRecord;
}
