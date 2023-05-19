import 'dart:async';
import 'package:clock_app/widgets/new_clock.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/constants/constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late String _timeString;

  @override
  void initState() {
    DateTime nowTime = DateTime.now();
    _timeString = _formatDateTime(nowTime);
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              toolbarHeight: 0,
              expandedHeight: 300,
              elevation: 10,
              backgroundColor: CustomColors.background,
              foregroundColor: CustomColors.foreground,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () {},
                  color: CustomColors.foreground,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.only(top: 50),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _timeString,
                      style: const TextStyle(
                        fontSize: 35,
                        letterSpacing: 5,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 20,
                      child: StepProgressIndicator(
                        totalSteps: 20,
                        currentStep: DateTime.now().second ~/ 3,
                        selectedSize: 5,
                        unselectedSize: 4,
                        selectedGradientColor: GradientColors.linearGrad,
                        unselectedColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              bottom: AppBar(
                backgroundColor: CustomColors.background,
                foregroundColor: CustomColors.foreground,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    onPressed: () {},
                    color: CustomColors.foreground,
                  ),
                ],
                title: ListTile(
                  leading: innerBoxIsScrolled
                      ? const Text(
                          "clock",
                          style: TextStyle(
                            fontSize: 18,
                            color: CustomColors.foreground,
                            letterSpacing: 1,
                          ),
                        )
                      : null,
                ),
              ))
        ];
      },
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                NewClock(),
                NewClock(),
                NewClock(),
                NewClock(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
