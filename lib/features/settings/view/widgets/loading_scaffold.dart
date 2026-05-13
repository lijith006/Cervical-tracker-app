import 'package:flutter/material.dart';
import 'package:cervical_tracker/core/theme/app_colors.dart';

class LoadingScaffold extends StatelessWidget {
  const LoadingScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBlue1,
      body: Center(child: CircularProgressIndicator(color: Colors.white38)),
    );
  }
}
