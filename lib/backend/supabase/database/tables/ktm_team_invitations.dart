import '../database.dart';

class KtmTeamInvitationsTable extends SupabaseTable<KtmTeamInvitationsRow> {
  @override
  String get tableName => 'ktm_team_invitations';

  @override
  KtmTeamInvitationsRow createRow(Map<String, dynamic> data) =>
      KtmTeamInvitationsRow(data);
}

class KtmTeamInvitationsRow extends SupabaseDataRow {
  KtmTeamInvitationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmTeamInvitationsTable();

  String get invitationId => getField<String>('invitation_id')!;
  set invitationId(String value) => setField<String>('invitation_id', value);

  String? get teamId => getField<String>('team_id');
  set teamId(String? value) => setField<String>('team_id', value);

  String get recieverId => getField<String>('reciever_id')!;
  set recieverId(String value) => setField<String>('reciever_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get invitedAt => getField<DateTime>('invited_at');
  set invitedAt(DateTime? value) => setField<DateTime>('invited_at', value);

  DateTime? get respondedAt => getField<DateTime>('responded_at');
  set respondedAt(DateTime? value) => setField<DateTime>('responded_at', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get senderId => getField<String>('sender_id')!;
  set senderId(String value) => setField<String>('sender_id', value);

  bool? get isTeamInvite => getField<bool>('is_teamInvite');
  set isTeamInvite(bool? value) => setField<bool>('is_teamInvite', value);
}
