import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/models/invitation_model.dart';

class InvitationService {
  InvitationService(this._client);

  final SupabaseClient _client;

  // =========================================================
  // SEND
  // =========================================================

  Future<void> sendInviteSecure({
    required String teamId,
    required String receiverId,
  }) async {
    await _safeRpcVoid(
      'send_team_invite_secure',
      params: {'p_team_id': teamId, 'p_receiver_id': receiverId},
    );
  }

  // =========================================================
  // ACCEPT
  // =========================================================

  Future<void> acceptInviteSecure(String invitationId) async {
    await _safeRpcVoid(
      'accept_team_invite_secure',
      params: {'p_invitation_id': invitationId},
    );
  }

  // =========================================================
  // READ (MY INVITES)
  // =========================================================

  Future<List<InvitationModel>> fetchMyInvites(String userId) async {
    try {
      final response = await _client
          .from('ktm_team_invitations')
          .select()
          .eq('receiver_id', userId)
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      final list = (response as List<dynamic>);
      return list.map((e) => InvitationModel.fromMap(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // READ (BY TOURNAMENT)
  // =========================================================

  Future<List<InvitationModel>> fetchInvitesByTournament(
    String tournamentId,
  ) async {
    try {
      final response = await _client
          .from('ktm_team_invitations')
          .select()
          .eq('tournament_id', tournamentId)
          .order('created_at', ascending: false);

      final list = (response as List<dynamic>);
      return list.map((e) => InvitationModel.fromMap(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // INTERNAL
  // =========================================================

  Future<void> _safeRpcVoid(String fn, {Map<String, dynamic>? params}) async {
    try {
      await _client.rpc(fn, params: params ?? {});
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(PostgrestException e) {
    if (e.code == 'P0001') return e.message;
    return 'Invitation operation failed';
  }
}
