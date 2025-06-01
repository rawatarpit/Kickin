import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReporteRecord extends FirestoreRecord {
  ReporteRecord._(
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

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as DocumentReference?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _comment = snapshotData['comment'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('reporte')
          : FirebaseFirestore.instance.collectionGroup('reporte');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('reporte').doc(id);

  static Stream<ReporteRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReporteRecord.fromSnapshot(s));

  static Future<ReporteRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReporteRecord.fromSnapshot(s));

  static ReporteRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReporteRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReporteRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReporteRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReporteRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReporteRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReporteRecordData({
  DocumentReference? userId,
  DateTime? timestamp,
  String? comment,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'timestamp': timestamp,
      'comment': comment,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReporteRecordDocumentEquality implements Equality<ReporteRecord> {
  const ReporteRecordDocumentEquality();

  @override
  bool equals(ReporteRecord? e1, ReporteRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.timestamp == e2?.timestamp &&
        e1?.comment == e2?.comment;
  }

  @override
  int hash(ReporteRecord? e) =>
      const ListEquality().hash([e?.userId, e?.timestamp, e?.comment]);

  @override
  bool isValidKey(Object? o) => o is ReporteRecord;
}
