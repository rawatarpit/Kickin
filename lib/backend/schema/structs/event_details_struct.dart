// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventDetailsStruct extends FFFirebaseStruct {
  EventDetailsStruct({
    String? imageUrl,
    String? eventName,
    List<String>? audience,
    String? date,
    String? time,
    String? description,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _imageUrl = imageUrl,
        _eventName = eventName,
        _audience = audience,
        _date = date,
        _time = time,
        _description = description,
        super(firestoreUtilData);

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  // "event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  set eventName(String? val) => _eventName = val;

  bool hasEventName() => _eventName != null;

  // "audience" field.
  List<String>? _audience;
  List<String> get audience => _audience ?? const [];
  set audience(List<String>? val) => _audience = val;

  void updateAudience(Function(List<String>) updateFn) {
    updateFn(_audience ??= []);
  }

  bool hasAudience() => _audience != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "time" field.
  String? _time;
  String get time => _time ?? '';
  set time(String? val) => _time = val;

  bool hasTime() => _time != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  static EventDetailsStruct fromMap(Map<String, dynamic> data) =>
      EventDetailsStruct(
        imageUrl: data['image_url'] as String?,
        eventName: data['event_name'] as String?,
        audience: getDataList(data['audience']),
        date: data['date'] as String?,
        time: data['time'] as String?,
        description: data['description'] as String?,
      );

  static EventDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? EventDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'image_url': _imageUrl,
        'event_name': _eventName,
        'audience': _audience,
        'date': _date,
        'time': _time,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'image_url': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
        'event_name': serializeParam(
          _eventName,
          ParamType.String,
        ),
        'audience': serializeParam(
          _audience,
          ParamType.String,
          isList: true,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'time': serializeParam(
          _time,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static EventDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventDetailsStruct(
        imageUrl: deserializeParam(
          data['image_url'],
          ParamType.String,
          false,
        ),
        eventName: deserializeParam(
          data['event_name'],
          ParamType.String,
          false,
        ),
        audience: deserializeParam<String>(
          data['audience'],
          ParamType.String,
          true,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        time: deserializeParam(
          data['time'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'EventDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EventDetailsStruct &&
        imageUrl == other.imageUrl &&
        eventName == other.eventName &&
        listEquality.equals(audience, other.audience) &&
        date == other.date &&
        time == other.time &&
        description == other.description;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([imageUrl, eventName, audience, date, time, description]);
}

EventDetailsStruct createEventDetailsStruct({
  String? imageUrl,
  String? eventName,
  String? date,
  String? time,
  String? description,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventDetailsStruct(
      imageUrl: imageUrl,
      eventName: eventName,
      date: date,
      time: time,
      description: description,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventDetailsStruct? updateEventDetailsStruct(
  EventDetailsStruct? eventDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventDetailsStructData(
  Map<String, dynamic> firestoreData,
  EventDetailsStruct? eventDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventDetails == null) {
    return;
  }
  if (eventDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventDetailsData =
      getEventDetailsFirestoreData(eventDetails, forFieldValue);
  final nestedData =
      eventDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventDetailsFirestoreData(
  EventDetailsStruct? eventDetails, [
  bool forFieldValue = false,
]) {
  if (eventDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventDetails.toMap());

  // Add any Firestore field values
  eventDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventDetailsListFirestoreData(
  List<EventDetailsStruct>? eventDetailss,
) =>
    eventDetailss?.map((e) => getEventDetailsFirestoreData(e, true)).toList() ??
    [];
