import 'package:flutter/material.dart';
import '../../../core/theme/kickin_typography.dart';

class MyNetworkScreen extends StatelessWidget {
  const MyNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('My Network', style: KickinTypography.h1));
  }
}
