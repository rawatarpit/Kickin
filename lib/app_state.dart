import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _usertype = prefs.getString('ff_usertype') ?? _usertype;
    });
    _safeInit(() {
      _Dob = prefs.getString('ff_Dob') ?? _Dob;
    });
    _safeInit(() {
      _position = prefs.getString('ff_position') ?? _position;
    });
    _safeInit(() {
      _currentclub = prefs.getString('ff_currentclub') ?? _currentclub;
    });
    _safeInit(() {
      _profilephoto = prefs.getString('ff_profilephoto') ?? _profilephoto;
    });
    _safeInit(() {
      _name = prefs.getString('ff_name') ?? _name;
    });
    _safeInit(() {
      _locations = prefs.getStringList('ff_locations') ?? _locations;
    });
    _safeInit(() {
      _resumecount = prefs.getInt('ff_resumecount') ?? _resumecount;
    });
    _safeInit(() {
      _resumeUrl = prefs.getString('ff_resumeUrl') ?? _resumeUrl;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// user type (eg.
  ///
  /// player,coach,club,agent)
  String _usertype = '';
  String get usertype => _usertype;
  set usertype(String value) {
    _usertype = value;
    prefs.setString('ff_usertype', value);
  }

  String _Dob = '';
  String get Dob => _Dob;
  set Dob(String value) {
    _Dob = value;
    prefs.setString('ff_Dob', value);
  }

  String _position = '';
  String get position => _position;
  set position(String value) {
    _position = value;
    prefs.setString('ff_position', value);
  }

  String _currentclub = '';
  String get currentclub => _currentclub;
  set currentclub(String value) {
    _currentclub = value;
    prefs.setString('ff_currentclub', value);
  }

  String _selectedRound = 'R1';
  String get selectedRound => _selectedRound;
  set selectedRound(String value) {
    _selectedRound = value;
  }

  List<String> _availableRounds = [];
  List<String> get availableRounds => _availableRounds;
  set availableRounds(List<String> value) {
    _availableRounds = value;
  }

  void addToAvailableRounds(String value) {
    availableRounds.add(value);
  }

  void removeFromAvailableRounds(String value) {
    availableRounds.remove(value);
  }

  void removeAtIndexFromAvailableRounds(int index) {
    availableRounds.removeAt(index);
  }

  void updateAvailableRoundsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    availableRounds[index] = updateFn(_availableRounds[index]);
  }

  void insertAtIndexInAvailableRounds(int index, String value) {
    availableRounds.insert(index, value);
  }

  String _profilephoto = '';
  String get profilephoto => _profilephoto;
  set profilephoto(String value) {
    _profilephoto = value;
    prefs.setString('ff_profilephoto', value);
  }

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    prefs.setString('ff_name', value);
  }

  List<String> _locations = [];
  List<String> get locations => _locations;
  set locations(List<String> value) {
    _locations = value;
    prefs.setStringList('ff_locations', value);
  }

  void addToLocations(String value) {
    locations.add(value);
    prefs.setStringList('ff_locations', _locations);
  }

  void removeFromLocations(String value) {
    locations.remove(value);
    prefs.setStringList('ff_locations', _locations);
  }

  void removeAtIndexFromLocations(int index) {
    locations.removeAt(index);
    prefs.setStringList('ff_locations', _locations);
  }

  void updateLocationsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    locations[index] = updateFn(_locations[index]);
    prefs.setStringList('ff_locations', _locations);
  }

  void insertAtIndexInLocations(int index, String value) {
    locations.insert(index, value);
    prefs.setStringList('ff_locations', _locations);
  }

  double _lat = 0.0;
  double get lat => _lat;
  set lat(double value) {
    _lat = value;
  }

  double _lng = 0.0;
  double get lng => _lng;
  set lng(double value) {
    _lng = value;
  }

  int _resumecount = 0;
  int get resumecount => _resumecount;
  set resumecount(int value) {
    _resumecount = value;
    prefs.setInt('ff_resumecount', value);
  }

  String _resumeUrl = '';
  String get resumeUrl => _resumeUrl;
  set resumeUrl(String value) {
    _resumeUrl = value;
    prefs.setString('ff_resumeUrl', value);
  }

  int _task = 0;
  int get task => _task;
  set task(int value) {
    _task = value;
  }

  List<String> _PreviewUrls = [];
  List<String> get PreviewUrls => _PreviewUrls;
  set PreviewUrls(List<String> value) {
    _PreviewUrls = value;
  }

  void addToPreviewUrls(String value) {
    PreviewUrls.add(value);
  }

  void removeFromPreviewUrls(String value) {
    PreviewUrls.remove(value);
  }

  void removeAtIndexFromPreviewUrls(int index) {
    PreviewUrls.removeAt(index);
  }

  void updatePreviewUrlsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    PreviewUrls[index] = updateFn(_PreviewUrls[index]);
  }

  void insertAtIndexInPreviewUrls(int index, String value) {
    PreviewUrls.insert(index, value);
  }

  final _messagesManager = StreamRequestManager<List<UsersRecord>>();
  Stream<List<UsersRecord>> messages({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UsersRecord>> Function() requestFn,
  }) =>
      _messagesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMessagesCache() => _messagesManager.clear();
  void clearMessagesCacheKey(String? uniqueKey) =>
      _messagesManager.clearRequest(uniqueKey);

  final _expManager = FutureRequestManager<List<UserExperienceRow>>();
  Future<List<UserExperienceRow>> exp({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserExperienceRow>> Function() requestFn,
  }) =>
      _expManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearExpCache() => _expManager.clear();
  void clearExpCacheKey(String? uniqueKey) =>
      _expManager.clearRequest(uniqueKey);

  final _profilepicManager = FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> profilepic({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _profilepicManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProfilepicCache() => _profilepicManager.clear();
  void clearProfilepicCacheKey(String? uniqueKey) =>
      _profilepicManager.clearRequest(uniqueKey);

  final _achievemenstManager = FutureRequestManager<List<AchievementsRow>>();
  Future<List<AchievementsRow>> achievemenst({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<AchievementsRow>> Function() requestFn,
  }) =>
      _achievemenstManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAchievemenstCache() => _achievemenstManager.clear();
  void clearAchievemenstCacheKey(String? uniqueKey) =>
      _achievemenstManager.clearRequest(uniqueKey);

  final _blockedUsersManager = StreamRequestManager<List<BlockedRecord>>();
  Stream<List<BlockedRecord>> blockedUsers({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<BlockedRecord>> Function() requestFn,
  }) =>
      _blockedUsersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearBlockedUsersCache() => _blockedUsersManager.clear();
  void clearBlockedUsersCacheKey(String? uniqueKey) =>
      _blockedUsersManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
