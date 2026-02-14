import 'package:flutter/material.dart';

import '../../features/home/ui/home_screen.dart';
import '../../features/jobs/ui/jobs_list_screen.dart';
import '../../features/tournaments/ui/screens/tournaments_list_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/tournaments/ui/screens/tournament_detail_screen.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    if (uri.path == AppRoutes.home) {
      return _page(const HomeScreen());
    }

    if (uri.path == AppRoutes.jobs) {
      return _page(const JobsListScreen());
    }

    if (uri.path == AppRoutes.tournaments) {
      return _page(const TournamentsListScreen());
    }

    if (uri.path == AppRoutes.profile) {
      return _page(const ProfileScreen());
    }

    // /tournament/:slug/:tab?
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'tournament') {
      if (uri.pathSegments.length >= 2) {
        final slug = uri.pathSegments[1];
        final tab = uri.pathSegments.length >= 3 ? uri.pathSegments[2] : null;

        return _page(TournamentDetailScreen(slug: slug, initialTab: tab));
      }
    }

    return _page(const HomeScreen());
  }

  static PageRoute _page(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
