import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clock_app/settings/constants.dart';
import 'package:clock_app/utils/utils.dart';

enum Mode { reset, started, stoped }

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  final List<DataRow> _lapsRows = [];
  late Timer _timer;
  Mode _mode = Mode.reset;
  String _result = "00:00:000";
  Duration _lastLapTime = "00:00:000".toTimerDuration();
  int _lapID = 0;

  void _start() {
    _timer = Timer.periodic(const Duration(microseconds: 10), (Timer timer) {
      setState(() {
        _result = _stopwatch.elapsed.toTimerString();
        _mode = Mode.started;
      });
      _stopwatch.start();
    });
  }

  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
    setState(() {
      _mode = Mode.stoped;
    });
  }

  void _lap() {
    Duration lapTimeDuration = _result.toTimerDuration() - _lastLapTime;
    _lapID++;

    DataRow lapRow = DataRow(cells: [
      DataCell(Center(child: Text(_lapID.toString()))),
      DataCell(Center(child: Text(lapTimeDuration.toTimerString()))),
      DataCell(Center(child: Text(_result)))
    ]);

    _lapsRows.insert(0, lapRow);
    _lastLapTime = _result.toTimerDuration();
    setState(() {});
  }

  void _reset() {
    _stop();
    _stopwatch.reset();
    setState(() {
      _result = "00:00:000";
      _mode = Mode.reset;
      _lapsRows.clear();
      _lastLapTime = "00:00:000".toTimerDuration();
      _lapID = 0;
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
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Lap")),
                  DataColumn(label: Text("Lap Times")),
                  DataColumn(label: Text("Overall Time")),
                ],
                rows: _lapsRows,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
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
