import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Image.asset(
            'assets/images/Splash_Screen-4.svg',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'home': ParameterData.none(),
  'welcome': (data) async => ParameterData(
        allParams: {
          'to': getParameter<bool>(data, 'to'),
        },
      ),
  'user_experience': (data) async => ParameterData(
        allParams: {
          'usertype': getParameter<String>(data, 'usertype'),
        },
      ),
  'create_account': ParameterData.none(),
  'privacyPolicy': ParameterData.none(),
  'terms_of_service': ParameterData.none(),
  'inbox': ParameterData.none(),
  'profile': ParameterData.none(),
  'my_network': (data) async => ParameterData(
        allParams: {
          'userId': getParameter<String>(data, 'userId'),
          'curentuser': getParameter<bool>(data, 'curentuser'),
          'name': getParameter<String>(data, 'name'),
        },
      ),
  'ktm_create_tournament': ParameterData.none(),
  'notifications': (data) async => ParameterData(
        allParams: {
          'tabIndex': getParameter<int>(data, 'tabIndex'),
        },
      ),
  'search_page': ParameterData.none(),
  'sign_up': ParameterData.none(),
  'kickin_shot': (data) async => ParameterData(
        allParams: {
          'postID': getParameter<DocumentReference>(data, 'postID'),
        },
      ),
  'reset_password': ParameterData.none(),
  'upload': ParameterData.none(),
  'indiviual_post': (data) async => ParameterData(
        allParams: {
          'postId': getParameter<String>(data, 'postId'),
        },
      ),
  'Job_Listing': ParameterData.none(),
  'chatMessage': (data) async => ParameterData(
        allParams: {
          'chatId': getParameter<String>(data, 'chatId'),
          'userId': getParameter<DocumentReference>(data, 'userId'),
          'postId': await getDocumentParameter<PostsRecord>(
              data, 'postId', PostsRecord.fromSnapshot),
        },
      ),
  'preview_event_page': (data) async => ParameterData(
        allParams: {
          'tournamentId': getParameter<String>(data, 'tournamentId'),
        },
      ),
  'event_page': (data) async => ParameterData(
        allParams: {
          'tournamentID': getParameter<String>(data, 'tournamentID'),
        },
      ),
  'event_details': (data) async => ParameterData(
        allParams: {
          'tabNumber': getParameter<int>(data, 'tabNumber'),
          'tournamentid': getParameter<String>(data, 'tournamentid'),
        },
      ),
  'events': (data) async => ParameterData(
        allParams: {
          'tabIndex': getParameter<int>(data, 'tabIndex'),
        },
      ),
  'event_Detailsorg': (data) async => ParameterData(
        allParams: {
          'tabNumber': getParameter<int>(data, 'tabNumber'),
          'tournamentId': getParameter<String>(data, 'tournamentId'),
        },
      ),
  'Otherprofile': (data) async => ParameterData(
        allParams: {
          'id': getParameter<String>(data, 'id'),
        },
      ),
  'edit_profile': ParameterData.none(),
  'groupChat': (data) async => ParameterData(
        allParams: {
          'chatId': getParameter<DocumentReference>(data, 'chatId'),
        },
      ),
  'refund_policy': ParameterData.none(),
  'About_us': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
