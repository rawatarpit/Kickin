import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommentsRecord extends FirestoreRecord {
  CommentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comment_id" field.
  String? _commentId;
  String get commentId => _commentId ?? '';
  bool hasCommentId() => _commentId != null;

  // "comment_text" field.
  String? _commentText;
  String get commentText => _commentText ?? '';
  bool hasCommentText() => _commentText != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "liked_by" field.
  List<DocumentReference>? _likedBy;
  List<DocumentReference> get likedBy => _likedBy ?? const [];
  bool hasLikedBy() => _likedBy != null;

  // "post_id" field.
  DocumentReference? _postId;
  DocumentReference? get postId => _postId;
  bool hasPostId() => _postId != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _commentId = snapshotData['comment_id'] as String?;
    _commentText = snapshotData['comment_text'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _likedBy = getDataList(snapshotData['liked_by']);
    _postId = snapshotData['post_id'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('comments')
          : FirebaseFirestore.instance.collectionGroup('comments');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('comments').doc(id);

  static Stream<CommentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommentsRecord.fromSnapshot(s));

  static Future<CommentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommentsRecord.fromSnapshot(s));

  static CommentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommentsRecordData({
  String? commentId,
  String? commentText,
  DocumentReference? userId,
  DateTime? createdTime,
  DocumentReference? postId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment_id': commentId,
      'comment_text': commentText,
      'user_id': userId,
      'created_time': createdTime,
      'post_id': postId,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommentsRecordDocumentEquality implements Equality<CommentsRecord> {
  const CommentsRecordDocumentEquality();

  @override
  bool equals(CommentsRecord? e1, CommentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.commentId == e2?.commentId &&
        e1?.commentText == e2?.commentText &&
        e1?.userId == e2?.userId &&
        e1?.createdTime == e2?.createdTime &&
        listEquality.equals(e1?.likedBy, e2?.likedBy) &&
        e1?.postId == e2?.postId;
  }

  @override
  int hash(CommentsRecord? e) => const ListEquality().hash([
        e?.commentId,
        e?.commentText,
        e?.userId,
        e?.createdTime,
        e?.likedBy,
        e?.postId
      ]);

  @override
  bool isValidKey(Object? o) => o is CommentsRecord;
}
