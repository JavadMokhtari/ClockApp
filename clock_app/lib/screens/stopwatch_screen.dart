import 'package:flutter/material.dart';
import 'package:clock_app/constants/colors.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Stop Watch Page",
        style: TextStyle(
          fontFamily: "ubuntu",
          fontSize: 30,
          color: CustomColors.foreground,
        ),
      ),
    );
  }
}
