import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/models/tournament_model.dart';
import '../domain/models/standing_model.dart';

class TournamentService {
  TournamentService(this._client);

  final SupabaseClient _client;

  // =========================================================
  // INTERNAL CACHE
  // =========================================================

  final Map<String, String> _slugToIdCache = {};

  // =========================================================
  // SLUG → ID RESOLUTION (STRICTLY INTERNAL)
  // =========================================================

  Future<String?> _resolveIdFromSlug(String slug) async {
    if (_slugToIdCache.containsKey(slug)) {
      return _slugToIdCache[slug];
    }

    final response =
        await _client
            .from('tournaments')
            .select('tournament_id')
            .eq('slug', slug)
            .maybeSingle();

    if (response == null) return null;

    final id = response['tournament_id'] as String;
    _slugToIdCache[slug] = id;

    return id;
  }

  void invalidateSlugCache(String slug) {
    _slugToIdCache.remove(slug);
  }

  // =========================================================
  // DISCOVER / LIST
  // =========================================================

  Future<List<TournamentModel>> fetchDiscoverTournaments() async {
    final data = await _safeRpcList('get_discover_tournaments');
    return data.map(TournamentModel.fromMap).toList();
  }

  Future<List<TournamentModel>> fetchNearbyTournaments({
    required double latitude,
    required double longitude,
  }) async {
    final data = await _safeRpcList(
      'nearby_tournaments',
      params: {'p_latitude': latitude, 'p_longitude': longitude},
    );

    return data.map(TournamentModel.fromMap).toList();
  }

  // =========================================================
  // DETAIL (SLUG FIRST)
  // =========================================================

  Future<TournamentModel?> fetchTournamentBySlug(String slug) async {
    try {
      final response =
          await _client
              .from('tournaments')
              .select()
              .eq('slug', slug)
              .maybeSingle();

      if (response == null) return null;

      // Cache ID internally
      final id = response['tournament_id'] as String;
      _slugToIdCache[slug] = id;

      return TournamentModel.fromMap(response);
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // SUMMARY (BY SLUG)
  // =========================================================

  Future<Map<String, dynamic>> fetchTournamentSummaryBySlug(String slug) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return {};

    return await _safeRpcSingle(
      'get_tournament_summary',
      params: {'p_tournament_id': id},
    );
  }

  Future<List<Map<String, dynamic>>> fetchTournamentRoundsBySlug(
    String slug,
  ) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return [];

    return await _safeRpcList(
      'get_tournament_rounds',
      params: {'p_tournament_id': id},
    );
  }

  // =========================================================
  // STANDINGS (BY SLUG)
  // =========================================================

  Future<List<StandingModel>> fetchStandingsBySlug(String slug) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return [];

    try {
      final response = await _client
          .from('ktm_group_standings')
          .select()
          .eq('tournament_id', id)
          .order('rank', ascending: true);

      final list = (response as List<dynamic>);
      return list.map((e) => StandingModel.fromMap(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // CREATE
  // =========================================================

  Future<void> createTournamentSecure({
    required Map<String, dynamic> payload,
  }) async {
    await _safeRpcVoid('create_tournament_secure', params: payload);
  }

  // =========================================================
  // MANAGEMENT (ALL SLUG BASED)
  // =========================================================

  Future<void> deleteTournamentSecure(String slug) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'delete_tournament_secure',
      params: {'p_tournament_id': id},
    );

    invalidateSlugCache(slug);
  }

  Future<void> toggleRegistrationSecure({
    required String slug,
    required bool allowRegistration,
  }) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'toggle_registration_secure',
      params: {
        'p_tournament_id': id,
        'p_allow_registration': allowRegistration,
      },
    );
  }

  Future<void> assignReporterSecure({
    required String slug,
    required String reporterId,
  }) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'assign_reporter_secure',
      params: {'p_tournament_id': id, 'p_reporter_id': reporterId},
    );
  }

  Future<void> updateTournamentGeolocation({
    required String slug,
    required double latitude,
    required double longitude,
  }) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'update_tournament_geolocation',
      params: {
        'p_tournament_id': id,
        'p_latitude': latitude,
        'p_longitude': longitude,
      },
    );
  }

  Future<void> changeStatus({
    required String slug,
    required String newStatus,
  }) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'change_tournament_status_secure',
      params: {'p_tournament_id': id, 'p_new_status': newStatus},
    );
  }

  Future<void> forceComplete(String slug) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'force_complete_tournament_secure',
      params: {'p_tournament_id': id},
    );
  }

  Future<void> cancelTournament(String slug) async {
    final id = await _resolveIdFromSlug(slug);
    if (id == null) return;

    await _safeRpcVoid(
      'cancel_tournament_secure',
      params: {'p_tournament_id': id},
    );
  }

  // =========================================================
  // INTERNAL SAFE HELPERS
  // =========================================================

  Future<List<Map<String, dynamic>>> _safeRpcList(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.rpc(functionName, params: params ?? {});
      final list = (response as List<dynamic>? ?? []);
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  Future<Map<String, dynamic>> _safeRpcSingle(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.rpc(functionName, params: params ?? {});
      return Map<String, dynamic>.from(response as Map);
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  Future<void> _safeRpcVoid(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      await _client.rpc(functionName, params: params ?? {});
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(PostgrestException e) {
    if (e.code == 'P0001') return e.message;
    return 'Tournament operation failed';
  }
}
