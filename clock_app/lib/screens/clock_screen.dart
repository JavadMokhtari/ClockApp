import 'dart:async';
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with TickerProviderStateMixin {
  late String _timeString;
  late AnimationController controller;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
      value: DateTime.now().second.toDouble() / 60.0,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(children: [
            Center(
              child: Text(
                _timeString,
                style: const TextStyle(
                  fontSize: 32,
                  letterSpacing: 3,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: CircularProgressIndicator(
                  value: controller.value,
                  strokeWidth: 2.0,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
