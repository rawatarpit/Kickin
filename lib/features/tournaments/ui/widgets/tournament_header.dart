import 'package:flutter/material.dart';
import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_typography.dart';
import '../../domain/models/tournament_model.dart';
import '../../domain/tournament_lifecycle.dart';

class TournamentHeader extends StatelessWidget {
  final TournamentModel tournament;
  final TournamentLifecycle lifecycle;
  final String? bannerUrl;
  final int teamCount;
  final bool showJoinButton;
  final VoidCallback? onJoinPressed;

  const TournamentHeader({
    super.key,
    required this.tournament,
    required this.lifecycle,
    required this.teamCount,
    this.bannerUrl,
    this.showJoinButton = false,
    this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width * 9 / 16;
    final hasBanner = bannerUrl != null && bannerUrl!.isNotEmpty;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child:
              hasBanner
                  ? Image.network(bannerUrl!, fit: BoxFit.cover)
                  : Container(
                    color: Colors.grey.shade900,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.emoji_events,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
        ),

        Container(
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black87, Colors.transparent],
            ),
          ),
        ),

        Positioned(
          left: KickinSpacing.lg,
          right: KickinSpacing.lg,
          bottom: KickinSpacing.lg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tournament.name,
                style: KickinTypography.h1.copyWith(color: Colors.white),
              ),

              const SizedBox(height: KickinSpacing.sm),

              Row(
                children: [
                  _buildStatusBadge(),
                  const SizedBox(width: KickinSpacing.md),
                  Text(
                    "$teamCount Teams",
                    style: KickinTypography.caption.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),

              if (tournament.hasWinner) ...[
                const SizedBox(height: KickinSpacing.sm),
                const Text(
                  "🏆 Winner Declared",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              if (showJoinButton && !lifecycle.isLocked) ...[
                const SizedBox(height: KickinSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onJoinPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Join Tournament"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    if (lifecycle.showLiveBanner) {
      return _badge("LIVE", Colors.red);
    }
    if (lifecycle.showCompletedBanner) {
      return _badge("COMPLETED", Colors.green);
    }
    if (lifecycle.showRegistrationBanner) {
      return _badge("REGISTRATION OPEN", Colors.blue);
    }
    if (lifecycle.showCancelledBanner) {
      return _badge("CANCELLED", Colors.orange);
    }
    return _badge("DRAFT", Colors.grey);
  }

  Widget _badge(String text, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
