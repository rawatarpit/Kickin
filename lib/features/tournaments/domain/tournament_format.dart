enum TournamentFormat { knockout, league, leaguePlusKnockout }

/// DB → Enum
TournamentFormat parseTournamentFormat(String? raw) {
  switch (raw) {
    case 'knockout':
      return TournamentFormat.knockout;
    case 'league':
      return TournamentFormat.league;
    case 'league_plus_knockout':
      return TournamentFormat.leaguePlusKnockout;
    default:
      return TournamentFormat.knockout;
  }
}

/// Enum → DB
String tournamentFormatToDb(TournamentFormat format) {
  switch (format) {
    case TournamentFormat.knockout:
      return 'knockout';
    case TournamentFormat.league:
      return 'league';
    case TournamentFormat.leaguePlusKnockout:
      return 'league_plus_knockout';
  }
}
