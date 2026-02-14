import 'package:flutter/animation.dart';

class KickinMotion {
  // Durations
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 320);

  // Curves
  static const Curve standard = Curves.easeOut;
  static const Curve emphasized = Curves.easeOutCubic;
}
