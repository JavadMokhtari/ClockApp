import 'package:flutter/material.dart';
import 'package:clock_app/constants/constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

enum PickerType { hour, minute, second }

enum Mode { started, paused, reset }

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final CountDownController _controller = CountDownController();
  Mode _mode = Mode.reset;
  int _hour = 0;
  int _minute = 0;
  int _second = 0;

  Widget customNumberPicker(PickerType time) => NumberPicker(
        minValue: 0,
        maxValue: time == PickerType.hour ? 23 : 59,
        value: time == PickerType.hour
            ? _hour
            : (time == PickerType.minute ? _minute : _second),
        onChanged: (int value) {
          setState(() {
            time == PickerType.hour
                ? _hour = value
                : (time == PickerType.minute
                    ? _minute = value
                    : _second = value);
          });
        },
        haptics: true,
        zeroPad: true,
        infiniteLoop: true,
        itemHeight: 60,
        textStyle: const TextStyle(
          fontFamily: "ubuntu",
          fontSize: 25,
          color: Color.fromARGB(80, 255, 255, 255),
        ),
        selectedTextStyle: const TextStyle(
          fontFamily: "ubuntu",
          fontSize: 30,
          color: CustomColors.foreground,
        ),
      );

  void _start() {
    setState(() {
      _mode = Mode.started;
    });
    _controller.start();
  }

  void _pause() {
    _controller.pause();
    setState(() {
      _mode = Mode.paused;
    });
  }

  void _resume() {
    _controller.resume();
    setState(() {
      _mode = Mode.started;
    });
  }

  void _delete() {
    _controller.reset();
    setState(() {
      _mode = Mode.reset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _mode == Mode.reset
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customNumberPicker(PickerType.hour),
                    customNumberPicker(PickerType.minute),
                    customNumberPicker(PickerType.second),
                  ],
                )
              : CircularCountDownTimer(
                  width: 200,
                  height: 200,
                  duration: _hour * 24 + _minute * 60 + _second,
                  isTimerTextShown: true,
                  isReverse: true,
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  controller: _controller,
                  fillColor: CustomColors.secondaryColor,
                  ringColor: CustomColors.navigationBarBackground,
                  fillGradient: GradientColors.linearGrad,
                  textStyle: const TextStyle(
                    fontFamily: "ubuntu",
                    fontSize: 30,
                    color: CustomColors.foreground,
                  ),
                ),
          _mode == Mode.reset
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: CustomColors.foreground,
                      disabledBackgroundColor:
                          const Color.fromARGB(100, 18, 18, 18),
                      disabledForegroundColor:
                          const Color.fromARGB(80, 255, 255, 255),
                      fixedSize: const Size(100, 40),
                      textStyle: const TextStyle(
                          fontSize: 15,
                          color: CustomColors.foreground,
                          fontFamily: "ubuntu",
                          letterSpacing: 1),
                    ),
                    onPressed: _hour * 24 + _minute * 60 + _second != 0
                        ? _start
                        : null,
                    child: const Text('Start'),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.navigationBarBackground,
                          foregroundColor: CustomColors.foreground,
                          fixedSize: const Size(100, 40),
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: CustomColors.foreground,
                              fontFamily: "ubuntu",
                              letterSpacing: 1),
                        ),
                        onPressed: _delete,
                        child: const Text('Delete'),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _mode == Mode.started
                              ? const Color.fromARGB(255, 160, 45, 45)
                              : Colors.deepPurple,
                          foregroundColor: CustomColors.foreground,
                          fixedSize: const Size(100, 40),
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: CustomColors.foreground,
                              fontFamily: "ubuntu",
                              letterSpacing: 1),
                        ),
                        onPressed: _mode == Mode.started ? _pause : _resume,
                        child: _mode == Mode.started
                            ? const Text('Pause')
                            : const Text("Resume"),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
