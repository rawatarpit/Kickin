import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'inbox_widget.dart' show InboxWidget;
import 'package:flutter/material.dart';

class InboxModel extends FlutterFlowModel<InboxWidget> {
  ///  Local state fields for this page.

  String? searchQuery;

  bool searchOn = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in inbox widget.
  List<ChatsRecord>? chats;
  // State field(s) for Search_user widget.
  FocusNode? searchUserFocusNode;
  TextEditingController? searchUserTextController;
  String? Function(BuildContext, String?)? searchUserTextControllerValidator;
  List<UsersRecord> simpleSearchResults1 = [];
  // State field(s) for Search_group widget.
  FocusNode? searchGroupFocusNode;
  TextEditingController? searchGroupTextController;
  String? Function(BuildContext, String?)? searchGroupTextControllerValidator;
  List<ChatsRecord> simpleSearchResults2 = [];
  // State field(s) for default_TabBar widget.
  TabController? defaultTabBarController;
  int get defaultTabBarCurrentIndex =>
      defaultTabBarController != null ? defaultTabBarController!.index : 0;
  int get defaultTabBarPreviousIndex => defaultTabBarController != null
      ? defaultTabBarController!.previousIndex
      : 0;

  // State field(s) for search_TabBar widget.
  TabController? searchTabBarController;
  int get searchTabBarCurrentIndex =>
      searchTabBarController != null ? searchTabBarController!.index : 0;
  int get searchTabBarPreviousIndex => searchTabBarController != null
      ? searchTabBarController!.previousIndex
      : 0;

  /// Query cache managers for this widget.

  final _usersManager = FutureRequestManager<List<UsersRecord>>();
  Future<List<UsersRecord>> users({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRecord>> Function() requestFn,
  }) =>
      _usersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUsersCache() => _usersManager.clear();
  void clearUsersCacheKey(String? uniqueKey) =>
      _usersManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchUserFocusNode?.dispose();
    searchUserTextController?.dispose();

    searchGroupFocusNode?.dispose();
    searchGroupTextController?.dispose();

    defaultTabBarController?.dispose();
    searchTabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearUsersCache();
  }
}
