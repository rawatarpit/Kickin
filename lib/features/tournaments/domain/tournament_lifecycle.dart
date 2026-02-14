enum TournamentStatus {
  draft,
  registrationOpen,
  registrationClosed,
  ongoing,
  completed,
  cancelled,
}

/// DB → Enum
TournamentStatus parseTournamentStatus(String? raw) {
  switch (raw) {
    case 'draft':
      return TournamentStatus.draft;
    case 'registration_open':
      return TournamentStatus.registrationOpen;
    case 'registration_closed':
      return TournamentStatus.registrationClosed;
    case 'ongoing':
      return TournamentStatus.ongoing;
    case 'completed':
      return TournamentStatus.completed;
    case 'cancelled':
      return TournamentStatus.cancelled;
    default:
      return TournamentStatus.draft;
  }
}

/// Enum → DB
String tournamentStatusToDb(TournamentStatus status) {
  switch (status) {
    case TournamentStatus.draft:
      return 'draft';
    case TournamentStatus.registrationOpen:
      return 'registration_open';
    case TournamentStatus.registrationClosed:
      return 'registration_closed';
    case TournamentStatus.ongoing:
      return 'ongoing';
    case TournamentStatus.completed:
      return 'completed';
    case TournamentStatus.cancelled:
      return 'cancelled';
  }
}

class TournamentLifecycle {
  final TournamentStatus status;
  final bool isOrganizer;

  const TournamentLifecycle({required this.status, required this.isOrganizer});

  // =====================================================
  // ORGANIZER PERMISSIONS
  // =====================================================

  bool get canEdit => isOrganizer && status == TournamentStatus.draft;

  bool get canOpenRegistration =>
      isOrganizer && status == TournamentStatus.draft;

  bool get canCloseRegistration =>
      isOrganizer && status == TournamentStatus.registrationOpen;

  bool get canStartTournament =>
      isOrganizer && status == TournamentStatus.registrationClosed;

  bool get canForceComplete =>
      isOrganizer && status == TournamentStatus.ongoing;

  bool get canCancel =>
      isOrganizer &&
      (status == TournamentStatus.draft ||
          status == TournamentStatus.registrationOpen ||
          status == TournamentStatus.registrationClosed);

  // =====================================================
  // PARTICIPATION
  // =====================================================

  bool get canCreateTeam => status == TournamentStatus.registrationOpen;

  bool get canInvitePlayers => status == TournamentStatus.registrationOpen;

  // =====================================================
  // MATCH CONTROL
  // =====================================================

  bool get canSubmitMatch => status == TournamentStatus.ongoing;

  bool get canAddMatchEvent => status == TournamentStatus.ongoing;

  // =====================================================
  // UI FLAGS
  // =====================================================

  bool get isLocked =>
      status == TournamentStatus.completed ||
      status == TournamentStatus.cancelled;

  bool get showRegistrationBanner =>
      status == TournamentStatus.registrationOpen;

  bool get showLiveBanner => status == TournamentStatus.ongoing;

  bool get showCompletedBanner => status == TournamentStatus.completed;

  bool get showCancelledBanner => status == TournamentStatus.cancelled;
}
