import 'package:flutter/material.dart';
import '../../../core/theme/kickin_colors.dart';

class ProfileTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;

  const ProfileTabs({super.key, required this.index, required this.onChange});

  static const tabs = ['Posts', 'Achievements', 'Experience'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (i) {
        final active = i == index;

        return GestureDetector(
          onTap: () => onChange(i),
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Column(
              children: [
                Text(
                  tabs[i],
                  style: TextStyle(
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color:
                        active ? KickinColors.primary : KickinColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: 36,
                  color: active ? KickinColors.primary : Colors.transparent,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
