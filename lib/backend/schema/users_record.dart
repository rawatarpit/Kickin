import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "locations" field.
  List<String>? _locations;
  List<String> get locations => _locations ?? const [];
  bool hasLocations() => _locations != null;

  // "DateofBirth" field.
  DateTime? _dateofBirth;
  DateTime? get dateofBirth => _dateofBirth;
  bool hasDateofBirth() => _dateofBirth != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "tournamentList" field.
  List<String>? _tournamentList;
  List<String> get tournamentList => _tournamentList ?? const [];
  bool hasTournamentList() => _tournamentList != null;

  // "chatList" field.
  List<DocumentReference>? _chatList;
  List<DocumentReference> get chatList => _chatList ?? const [];
  bool hasChatList() => _chatList != null;

  // "requestedList" field.
  List<String>? _requestedList;
  List<String> get requestedList => _requestedList ?? const [];
  bool hasRequestedList() => _requestedList != null;

  // "connectedList" field.
  List<String>? _connectedList;
  List<String> get connectedList => _connectedList ?? const [];
  bool hasConnectedList() => _connectedList != null;

  // "blockedList" field.
  List<String>? _blockedList;
  List<String> get blockedList => _blockedList ?? const [];
  bool hasBlockedList() => _blockedList != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _role = snapshotData['role'] as String?;
    _locations = getDataList(snapshotData['locations']);
    _dateofBirth = snapshotData['DateofBirth'] as DateTime?;
    _bio = snapshotData['bio'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _tournamentList = getDataList(snapshotData['tournamentList']);
    _chatList = getDataList(snapshotData['chatList']);
    _requestedList = getDataList(snapshotData['requestedList']);
    _connectedList = getDataList(snapshotData['connectedList']);
    _blockedList = getDataList(snapshotData['blockedList']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  String? role,
  DateTime? dateofBirth,
  String? bio,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'role': role,
      'DateofBirth': dateofBirth,
      'bio': bio,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.role == e2?.role &&
        listEquality.equals(e1?.locations, e2?.locations) &&
        e1?.dateofBirth == e2?.dateofBirth &&
        e1?.bio == e2?.bio &&
        e1?.createdTime == e2?.createdTime &&
        listEquality.equals(e1?.tournamentList, e2?.tournamentList) &&
        listEquality.equals(e1?.chatList, e2?.chatList) &&
        listEquality.equals(e1?.requestedList, e2?.requestedList) &&
        listEquality.equals(e1?.connectedList, e2?.connectedList) &&
        listEquality.equals(e1?.blockedList, e2?.blockedList);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber,
        e?.role,
        e?.locations,
        e?.dateofBirth,
        e?.bio,
        e?.createdTime,
        e?.tournamentList,
        e?.chatList,
        e?.requestedList,
        e?.connectedList,
        e?.blockedList
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
