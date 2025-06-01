import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start SupabaseKickinEvent Group Code

class SupabaseKickinEventGroup {
  static String getBaseUrl() => 'https://grbbdskhtdettoddpxfl.supabase.co';
  static Map<String, String> headers = {
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
    'Content-Type': 'application/json',
  };
  static GenerateInitialFixturesCall generateInitialFixturesCall =
      GenerateInitialFixturesCall();
  static GetTournamentRoundsCall getTournamentRoundsCall =
      GetTournamentRoundsCall();
  static GetTournamentRoundsKickinCall getTournamentRoundsKickinCall =
      GetTournamentRoundsKickinCall();
  static GetTournamentRoundsKickinLoserCall getTournamentRoundsKickinLoserCall =
      GetTournamentRoundsKickinLoserCall();
  static KTMGenerateKnockoutInitalFixturesCall
      kTMGenerateKnockoutInitalFixturesCall =
      KTMGenerateKnockoutInitalFixturesCall();
  static KTMAssignTeamsToGroupsCall kTMAssignTeamsToGroupsCall =
      KTMAssignTeamsToGroupsCall();
  static KTMGenerateGroupFixturesCall kTMGenerateGroupFixturesCall =
      KTMGenerateGroupFixturesCall();
  static KTMGenerateGroupKnockoutFixturesCall
      kTMGenerateGroupKnockoutFixturesCall =
      KTMGenerateGroupKnockoutFixturesCall();
  static SuggestedUsersCall suggestedUsersCall = SuggestedUsersCall();
  static NearbyTournamentsCall nearbyTournamentsCall = NearbyTournamentsCall();
  static NearbyUsersCall nearbyUsersCall = NearbyUsersCall();
  static UpdateLocationCall updateLocationCall = UpdateLocationCall();
  static EventInviationsCall eventInviationsCall = EventInviationsCall();
  static TeamInvitationCall teamInvitationCall = TeamInvitationCall();
  static TeamListCall teamListCall = TeamListCall();
  static StandingsCall standingsCall = StandingsCall();
  static DeleteConnectionsCall deleteConnectionsCall = DeleteConnectionsCall();
}

class GenerateInitialFixturesCall {
  Future<ApiCallResponse> call({
    String? pTournamentId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Generate Initial Fixtures',
      apiUrl: '${baseUrl}/rest/v1/rpc/generate_initial_fixtures',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTournamentRoundsCall {
  Future<ApiCallResponse> call({
    String? tournamentUuid = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "tournament_uuid": "${escapeStringForJson(tournamentUuid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Tournament Rounds',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_tournament_rounds',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? rounds(dynamic response) => (getJsonField(
        response,
        r'''$[:].round_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetTournamentRoundsKickinCall {
  Future<ApiCallResponse> call({
    String? tournamentUuid = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "tournament_uuid": "${escapeStringForJson(tournamentUuid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Tournament Rounds Kickin',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_tournament_rounds_kickin',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? rounds(dynamic response) => (getJsonField(
        response,
        r'''$[:].round_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetTournamentRoundsKickinLoserCall {
  Future<ApiCallResponse> call({
    String? tournamentUuid = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "tournament_uuid": "${escapeStringForJson(tournamentUuid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Tournament Rounds Kickin loser',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_tournament_rounds_kickin_loser',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? rounds(dynamic response) => (getJsonField(
        response,
        r'''$[:].round_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class KTMGenerateKnockoutInitalFixturesCall {
  Future<ApiCallResponse> call({
    String? pTournamentId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'KTM Generate Knockout  Inital Fixtures',
      apiUrl: '${baseUrl}/rest/v1/rpc/ktm_generate_knockout_initial_fixtures',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? errorMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class KTMAssignTeamsToGroupsCall {
  Future<ApiCallResponse> call({
    String? pTournamentId = '',
    String? pTeamsPerGroup = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}",
  "p_teams_per_group": "${escapeStringForJson(pTeamsPerGroup)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'KTM Assign Teams To Groups',
      apiUrl: '${baseUrl}/rest/v1/rpc/ktm_assign_teams_to_groups',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? errorMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class KTMGenerateGroupFixturesCall {
  Future<ApiCallResponse> call({
    String? pTournamentId = '',
    String? pMatchType = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}",
  "p_match_type": "${escapeStringForJson(pMatchType)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'KTM Generate Group Fixtures',
      apiUrl: '${baseUrl}/rest/v1/rpc/ktm_generate_group_fixtures_homeaway',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class KTMGenerateGroupKnockoutFixturesCall {
  Future<ApiCallResponse> call({
    String? pTournamentId = '',
    int? pTopNPerGroup,
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}",
  "p_top_n_per_group": ${pTopNPerGroup}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'KTM Generate Group Knockout Fixtures',
      apiUrl: '${baseUrl}/rest/v1/rpc/ktm_generate_group_knockout_fixtures',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SuggestedUsersCall {
  Future<ApiCallResponse> call({
    String? currentUid = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "current_uid": "${escapeStringForJson(currentUid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Suggested Users',
      apiUrl:
          '${baseUrl}/rest/v1/rpc/get_suggested_users_with_connection_level',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? users(dynamic response) => (getJsonField(
        response,
        r'''$[:].user_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? profile(dynamic response) => (getJsonField(
        response,
        r'''$[:].profile_pic''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? role(dynamic response) => (getJsonField(
        response,
        r'''$[:].role''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? mutualCount(dynamic response) => (getJsonField(
        response,
        r'''$[:].mutual_count''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? mutuals(dynamic response) => getJsonField(
        response,
        r'''$[:].mutual_user_ids''',
        true,
      ) as List?;
}

class NearbyTournamentsCall {
  Future<ApiCallResponse> call({
    double? radiusKm,
    String? currentUserId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "current_user_id": "${escapeStringForJson(currentUserId)}",
  "radius_km": ${radiusKm}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Nearby Tournaments',
      apiUrl: '${baseUrl}/rest/v1/rpc/nearby_tournaments',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? tournamentId(dynamic response) => (getJsonField(
        response,
        r'''$[:].tournament_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? startDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].start_date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? location(dynamic response) => (getJsonField(
        response,
        r'''$[:].location''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$[:].media_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NearbyUsersCall {
  Future<ApiCallResponse> call({
    String? currentUserId = '',
    double? radiusKm,
    String? userType = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "current_user_id": "${escapeStringForJson(currentUserId)}",
  "radius_km": ${radiusKm},
  "user_type": "${escapeStringForJson(userType)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Nearby Users',
      apiUrl: '${baseUrl}/rest/v1/rpc/nearby_users',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? userId(dynamic response) => (getJsonField(
        response,
        r'''$[:].user_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? profilePic(dynamic response) => (getJsonField(
        response,
        r'''$[:].profile_pic''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? role(dynamic response) => (getJsonField(
        response,
        r'''$[:].role''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateLocationCall {
  Future<ApiCallResponse> call({
    String? uid = '',
    String? lat = '',
    String? lon = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "uid": "${escapeStringForJson(uid)}",
  "lat": "${escapeStringForJson(lat)}",
  "lon": "${escapeStringForJson(lon)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update Location',
      apiUrl: '${baseUrl}/rest/v1/rpc/update_user_geolocation',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EventInviationsCall {
  Future<ApiCallResponse> call({
    String? pUserId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_user_id": "${escapeStringForJson(pUserId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'event Inviations',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_user_team_invitations',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? invitationId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].invitation_id''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].status''',
      ));
  String? invitedAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].invited_at''',
      ));
  String? teamNAme(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].team_name''',
      ));
  String? keyMember(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].key_member_id''',
      ));
  String? keyName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].key_member_name''',
      ));
  String? tournamentId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].tournament_id''',
      ));
  String? tournamentName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].tournament_name''',
      ));
  String? mediaUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].media_url''',
      ));
  String? startDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].start_date''',
      ));
  String? invitedago(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].invited_ago''',
      ));
  String? location(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].location''',
      ));
}

class TeamInvitationCall {
  Future<ApiCallResponse> call({
    String? pUserId = '',
    String? pTournamentId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_user_id": "${escapeStringForJson(pUserId)}",
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'team Invitation ',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_user_team_invitations_for_tournament',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? invitationid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].invitation_id''',
      ));
  String? teamname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].team_name''',
      ));
  String? teamid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].team_id''',
      ));
  String? keymemberid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].key_member_id''',
      ));
}

class TeamListCall {
  Future<ApiCallResponse> call({
    String? pTeamId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "p_team_id": "${escapeStringForJson(pTeamId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'team List',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_team_members_with_details',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? memberid(dynamic response) => (getJsonField(
        response,
        r'''$[:].member_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? userid(dynamic response) => (getJsonField(
        response,
        r'''$[:].user_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? joinedat(dynamic response) => (getJsonField(
        response,
        r'''$[:].joined_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? profilepic(dynamic response) => (getJsonField(
        response,
        r'''$[:].profile_pic''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? role(dynamic response) => (getJsonField(
        response,
        r'''$[:].role''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? teamName(dynamic response) => (getJsonField(
        response,
        r'''$[:].team_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class StandingsCall {
  Future<ApiCallResponse> call({
    String? inputTournamentId = '',
    String? inputGroupId = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "input_tournament_id": "${escapeStringForJson(inputTournamentId)}",
  "input_group_id": "${escapeStringForJson(inputGroupId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'standings',
      apiUrl: '${baseUrl}/rest/v1/rpc/get_group_standings',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<int>? mp(dynamic response) => (getJsonField(
        response,
        r'''$[:].matches_played''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? win(dynamic response) => (getJsonField(
        response,
        r'''$[:].wins''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? draw(dynamic response) => (getJsonField(
        response,
        r'''$[:].draws''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? loss(dynamic response) => (getJsonField(
        response,
        r'''$[:].losses''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? gf(dynamic response) => (getJsonField(
        response,
        r'''$[:].goals_for''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? ga(dynamic response) => (getJsonField(
        response,
        r'''$[:].goals_against''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? gd(dynamic response) => (getJsonField(
        response,
        r'''$[:].goal_difference''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? points(dynamic response) => (getJsonField(
        response,
        r'''$[:].points''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? rank(dynamic response) => (getJsonField(
        response,
        r'''$[:].rank''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? groupName(dynamic response) => (getJsonField(
        response,
        r'''$[:].group_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? teamName(dynamic response) => (getJsonField(
        response,
        r'''$[:].team_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class DeleteConnectionsCall {
  Future<ApiCallResponse> call({
    String? userId1 = '',
    String? userId2 = '',
  }) async {
    final baseUrl = SupabaseKickinEventGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id_1": "${escapeStringForJson(userId1)}",
  "user_id_2": "${escapeStringForJson(userId2)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'delete connections',
      apiUrl: '${baseUrl}/rest/v1/rpc/delete_connection',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End SupabaseKickinEvent Group Code

/// Start Payment Group Code

class PaymentGroup {
  static String getBaseUrl() =>
      'https://grbbdskhtdettoddpxfl.supabase.co/functions/v1';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
  };
  static CreatePaymentOrderCall createPaymentOrderCall =
      CreatePaymentOrderCall();
  static TokenCall tokenCall = TokenCall();
  static OrderStatusCall orderStatusCall = OrderStatusCall();
}

class CreatePaymentOrderCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? subscriptionId = '',
    String? tournamentId = '',
    bool? isTournament,
    String? redirectUrl = '',
  }) async {
    final baseUrl = PaymentGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(userId)}",
  "subscription_id": "${escapeStringForJson(subscriptionId)}",
  "tournament_id": "${escapeStringForJson(tournamentId)}",
  "is_tournament": ${isTournament},
  "redirect_url": "${escapeStringForJson(redirectUrl)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Payment Order',
      apiUrl: '${baseUrl}/CreatePaymentOrder',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
  dynamic details(dynamic response) => getJsonField(
        response,
        r'''$.details''',
      );
  String? detailsmessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.details.message''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  String? orderId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.phonepeData.orderId''',
      ));
  String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.phonepeData.state''',
      ));
  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.phonepeData.redirectUrl''',
      ));
  int? expiresAt(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.phonepeData.expireAt''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.phonepeData''',
      );
}

class TokenCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = PaymentGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'token',
      apiUrl: '${baseUrl}/phonepeToken',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OrderStatusCall {
  Future<ApiCallResponse> call({
    String? phonepeMerchantOrderId = '',
  }) async {
    final baseUrl = PaymentGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "phonepe_merchant_order_id": "${escapeStringForJson(phonepeMerchantOrderId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'orderStatus',
      apiUrl: '${baseUrl}/orderStatus',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.state''',
      ));
  String? orderID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.orderId''',
      ));
  dynamic details(dynamic response) => getJsonField(
        response,
        r'''$.paymentDetails[:].rail''',
      );
  String? transcationType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentDetails[:].rail.type''',
      ));
}

/// End Payment Group Code

class KtmadvanceknockoutroundCall {
  static Future<ApiCallResponse> call({
    String? tournamentId = '',
    String? round = '',
  }) async {
    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(tournamentId)}",
  "p_round": "${escapeStringForJson(round)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ktmadvanceknockoutround',
      apiUrl:
          'https://grbbdskhtdettoddpxfl.supabase.co/rest/v1/rpc/ktm_advance_knockout_round',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PlaceSearchCall {
  static Future<ApiCallResponse> call({
    String? query = '',
  }) async {
    final ffApiRequestBody = '''
{
  "query": "${escapeStringForJson(query)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PlaceSearch',
      apiUrl:
          'https://grbbdskhtdettoddpxfl.supabase.co/functions/v1/places-search',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? suggestions(dynamic response) => getJsonField(
        response,
        r'''$.suggestions''',
        true,
      ) as List?;
  static List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.suggestions[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? placeid(dynamic response) => (getJsonField(
        response,
        r'''$.suggestions[:].place_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.suggestions[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? address(dynamic response) => (getJsonField(
        response,
        r'''$.suggestions[:].address''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? location(dynamic response) => getJsonField(
        response,
        r'''$.suggestions[:].location''',
        true,
      ) as List?;
  static List<double>? lat(dynamic response) => (getJsonField(
        response,
        r'''$.suggestions[:].location.lat''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? lng(dynamic response) => (getJsonField(
        response,
        r'''$.suggestions[:].location.lng''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
}

class UpdateTournamentGeolocationCall {
  static Future<ApiCallResponse> call({
    String? pTournamentId = '',
    double? pLat,
    double? pLng,
  }) async {
    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}",
  "p_lat": ${pLat},
  "p_lng": ${pLng}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Update Tournament Geolocation',
      apiUrl:
          'https://grbbdskhtdettoddpxfl.supabase.co/rest/v1/rpc/update_tournament_geolocation',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EventPageMediaCall {
  static Future<ApiCallResponse> call({
    String? pTournamentId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "p_tournament_id": "${escapeStringForJson(pTournamentId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Event Page Media',
      apiUrl:
          'https://grbbdskhtdettoddpxfl.supabase.co/rest/v1/rpc/get_tournament_media_and_ads',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczOTI4Njk2MiwiZXhwIjoyMDU0ODYyOTYyfQ.jgimbSDp7nHbEEngHR_TQrgThjAihegQe7L24YwQbzQ',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? isAd(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].is_ad''',
      ));
  static List? redirectUrl(dynamic response) => getJsonField(
        response,
        r'''$[:].redirect_url''',
        true,
      ) as List?;
  static List<String>? media(dynamic response) => (getJsonField(
        response,
        r'''$[:].media_url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? id(dynamic response) => getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?;
}

class KickinMediaAdsCall {
  static Future<ApiCallResponse> call({
    String? pAdId = '',
    String? pUserId = '',
    String? pMode = '',
  }) async {
    final ffApiRequestBody = '''
{
  "p_ad_id": "${escapeStringForJson(pAdId)}",
  "p_user_id": "${escapeStringForJson(pUserId)}",
  "p_mode": "${escapeStringForJson(pMode)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'kickin Media ads',
      apiUrl:
          'https://grbbdskhtdettoddpxfl.supabase.co/rest/v1/rpc/update_kickin_ad_metrics',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYmJkc2todGRldHRvZGRweGZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyODY5NjIsImV4cCI6MjA1NDg2Mjk2Mn0.tsBV_nawqq7mT5mhwfosmDriDg2be4zUAnlPNSIywCs',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ResumeCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'resume',
      apiUrl:
          'https://us-central1-kickin-9s7gfx.cloudfunctions.net/generateResume',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ConversationCall {
  static Future<ApiCallResponse> call({
    String? receiverId = '',
    String? text = '',
    String? type = '',
    String? postId = '',
    String? storyId = '',
    String? senderId = '',
    List<String>? mediaList,
  }) async {
    final media = _serializeList(mediaList);

    final ffApiRequestBody = '''
{
  "sender_id": "${escapeStringForJson(senderId)}",
  "receiver_id": "${escapeStringForJson(receiverId)}",
  "text": "${escapeStringForJson(text)}",
  "type": "${escapeStringForJson(type)}",
  "post_id": "${escapeStringForJson(postId)}",
  "story_id": "${escapeStringForJson(storyId)}",
  "media": ${media}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Conversation',
      apiUrl:
          'https://us-central1-kickin-9s7gfx.cloudfunctions.net/startOrContinueConversation',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? messageId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message_id''',
      ));
  static String? chatId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.chat_id''',
      ));
  static bool? apimessage(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class DeleteFileCall {
  static Future<ApiCallResponse> call({
    String? publicUrl = '',
  }) async {
    final ffApiRequestBody = '''
{
  "publicUrl": "${escapeStringForJson(publicUrl)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Delete File',
      apiUrl: 'https://us-central1-kickin-9s7gfx.cloudfunctions.net/deleteFile',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? messageId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message_id''',
      ));
  static String? chatId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.chat_id''',
      ));
  static bool? apimessage(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
