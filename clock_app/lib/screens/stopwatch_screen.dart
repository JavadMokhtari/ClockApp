import 'package:clock_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.background,
      bottomNavigationBar: ClockAppBottomNavigationBar(),
    );
  }
}
