enum TournamentTab { teams, scores, standings }

TournamentTab parseTournamentTab(String? value) {
  switch (value) {
    case 'teams':
      return TournamentTab.teams;
    case 'scores':
      return TournamentTab.scores;
    case 'standings':
      return TournamentTab.standings;
    default:
      return TournamentTab.teams;
  }
}

String tournamentTabToPath(TournamentTab tab) {
  switch (tab) {
    case TournamentTab.teams:
      return 'teams';
    case TournamentTab.scores:
      return 'scores';
    case TournamentTab.standings:
      return 'standings';
  }
}
