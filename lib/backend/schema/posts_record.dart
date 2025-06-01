import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostsRecord extends FirestoreRecord {
  PostsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "post_description" field.
  String? _postDescription;
  String get postDescription => _postDescription ?? '';
  bool hasPostDescription() => _postDescription != null;

  // "time_posted" field.
  DateTime? _timePosted;
  DateTime? get timePosted => _timePosted;
  bool hasTimePosted() => _timePosted != null;

  // "likes" field.
  List<DocumentReference>? _likes;
  List<DocumentReference> get likes => _likes ?? const [];
  bool hasLikes() => _likes != null;

  // "num_comments" field.
  int? _numComments;
  int get numComments => _numComments ?? 0;
  bool hasNumComments() => _numComments != null;

  // "num_votes" field.
  int? _numVotes;
  int get numVotes => _numVotes ?? 0;
  bool hasNumVotes() => _numVotes != null;

  // "posts_id" field.
  String? _postsId;
  String get postsId => _postsId ?? '';
  bool hasPostsId() => _postsId != null;

  // "mediauUrl" field.
  List<String>? _mediauUrl;
  List<String> get mediauUrl => _mediauUrl ?? const [];
  bool hasMediauUrl() => _mediauUrl != null;

  // "is_shot" field.
  bool? _isShot;
  bool get isShot => _isShot ?? false;
  bool hasIsShot() => _isShot != null;

  // "user_post" field.
  String? _userPost;
  String get userPost => _userPost ?? '';
  bool hasUserPost() => _userPost != null;

  // "for_everyone" field.
  bool? _forEveryone;
  bool get forEveryone => _forEveryone ?? false;
  bool hasForEveryone() => _forEveryone != null;

  // "event_details" field.
  EventDetailsStruct? _eventDetails;
  EventDetailsStruct get eventDetails => _eventDetails ?? EventDetailsStruct();
  bool hasEventDetails() => _eventDetails != null;

  // "is_event" field.
  bool? _isEvent;
  bool get isEvent => _isEvent ?? false;
  bool hasIsEvent() => _isEvent != null;

  // "post_type" field.
  String? _postType;
  String get postType => _postType ?? '';
  bool hasPostType() => _postType != null;

  void _initializeFields() {
    _postDescription = snapshotData['post_description'] as String?;
    _timePosted = snapshotData['time_posted'] as DateTime?;
    _likes = getDataList(snapshotData['likes']);
    _numComments = castToType<int>(snapshotData['num_comments']);
    _numVotes = castToType<int>(snapshotData['num_votes']);
    _postsId = snapshotData['posts_id'] as String?;
    _mediauUrl = getDataList(snapshotData['mediauUrl']);
    _isShot = snapshotData['is_shot'] as bool?;
    _userPost = snapshotData['user_post'] as String?;
    _forEveryone = snapshotData['for_everyone'] as bool?;
    _eventDetails = snapshotData['event_details'] is EventDetailsStruct
        ? snapshotData['event_details']
        : EventDetailsStruct.maybeFromMap(snapshotData['event_details']);
    _isEvent = snapshotData['is_event'] as bool?;
    _postType = snapshotData['post_type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PostsRecord.fromSnapshot(s));

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PostsRecord.fromSnapshot(s));

  static PostsRecord fromSnapshot(DocumentSnapshot snapshot) => PostsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PostsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PostsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PostsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PostsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPostsRecordData({
  String? postDescription,
  DateTime? timePosted,
  int? numComments,
  int? numVotes,
  String? postsId,
  bool? isShot,
  String? userPost,
  bool? forEveryone,
  EventDetailsStruct? eventDetails,
  bool? isEvent,
  String? postType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'post_description': postDescription,
      'time_posted': timePosted,
      'num_comments': numComments,
      'num_votes': numVotes,
      'posts_id': postsId,
      'is_shot': isShot,
      'user_post': userPost,
      'for_everyone': forEveryone,
      'event_details': EventDetailsStruct().toMap(),
      'is_event': isEvent,
      'post_type': postType,
    }.withoutNulls,
  );

  // Handle nested data for "event_details" field.
  addEventDetailsStructData(firestoreData, eventDetails, 'event_details');

  return firestoreData;
}

class PostsRecordDocumentEquality implements Equality<PostsRecord> {
  const PostsRecordDocumentEquality();

  @override
  bool equals(PostsRecord? e1, PostsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.postDescription == e2?.postDescription &&
        e1?.timePosted == e2?.timePosted &&
        listEquality.equals(e1?.likes, e2?.likes) &&
        e1?.numComments == e2?.numComments &&
        e1?.numVotes == e2?.numVotes &&
        e1?.postsId == e2?.postsId &&
        listEquality.equals(e1?.mediauUrl, e2?.mediauUrl) &&
        e1?.isShot == e2?.isShot &&
        e1?.userPost == e2?.userPost &&
        e1?.forEveryone == e2?.forEveryone &&
        e1?.eventDetails == e2?.eventDetails &&
        e1?.isEvent == e2?.isEvent &&
        e1?.postType == e2?.postType;
  }

  @override
  int hash(PostsRecord? e) => const ListEquality().hash([
        e?.postDescription,
        e?.timePosted,
        e?.likes,
        e?.numComments,
        e?.numVotes,
        e?.postsId,
        e?.mediauUrl,
        e?.isShot,
        e?.userPost,
        e?.forEveryone,
        e?.eventDetails,
        e?.isEvent,
        e?.postType
      ]);

  @override
  bool isValidKey(Object? o) => o is PostsRecord;
}
