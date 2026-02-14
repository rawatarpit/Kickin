double computeDiscoveryScore({
  required double distanceKm,
  required int mutualCount,
}) {
  final distanceScore = 1 / (1 + distanceKm);
  final mutualBoost = mutualCount.clamp(0, 5) * 0.15;

  return distanceScore + mutualBoost;
}
