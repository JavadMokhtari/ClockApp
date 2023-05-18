import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clock_app/constants/constants.dart';
import 'package:clock_app/utils/utils.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

enum Mode { reset, started, stoped }

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  Mode _mode = Mode.reset;
  String _result = "00:00:00";
  List<DataCell> _lapTimes = [];

  void _start() {
    _timer = Timer.periodic(const Duration(microseconds: 35), (Timer timer) {
      setState(() {
        String minute = _stopwatch.elapsed.inMinutes.toTimeString();
        String second = _stopwatch.elapsed.inSeconds.toTimeString();
        String milliSecond = _stopwatch.elapsed.inMilliseconds.toTimeString();

        _result = "$minute:$second:$milliSecond";
        _mode = Mode.started;
      });
    });
    _stopwatch.start();
  }

  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
    setState(() {
      _mode = Mode.stoped;
    });
  }

  void _lap() {
    String minute = _stopwatch.elapsed.inMinutes.toTimeString();
    String second = _stopwatch.elapsed.inSeconds.toTimeString();
    String milliSecond = _stopwatch.elapsed.inMilliseconds.toTimeString();

    String lapTime;
    lapTime = "$minute:$second:$milliSecond";
    setState(() {
      _lapTimes.add(DataCell(Text(lapTime)));
    });
  }

  void _reset() {
    _stop();
    _stopwatch.reset();
    setState(() {
      _result = "00:00:00";
      _mode = Mode.reset;
      _lapTimes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            _result,
            style: const TextStyle(
              color: CustomColors.foreground,
              fontSize: 60,
              letterSpacing: 5,
            ),
          ),
          DataTable(columns: const [
            DataColumn(label: Text("Lap")),
            DataColumn(label: Text("Lap Times")),
            DataColumn(label: Text("Overall Time")),
          ], rows: [
            DataRow(cells: _lapTimes)
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.navigationBarBackground,
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
                    onPressed: _mode == Mode.started
                        ? _lap
                        : (_mode == Mode.stoped ? _reset : null),
                    child: _mode != Mode.stoped
                        ? const Text('Lap')
                        : const Text('Reset'),
                  ),
                ),
                ClipRRect(
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
                      onPressed: _mode == Mode.started ? _stop : _start,
                      child: _mode == Mode.reset
                          ? const Text('Start')
                          : (_mode == Mode.started
                              ? const Text('Stop')
                              : const Text("Resume"))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
