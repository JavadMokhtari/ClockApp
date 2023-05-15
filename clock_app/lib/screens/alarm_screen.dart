import 'package:clock_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Widget> _alarmsList = [];
  List<String> _loadedAlarms = [];

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final SharedPreferences prefs = await _prefs;
    List<String> loadedAlarms;
    List<Widget> alarmsList = [];
    setState(() {
      loadedAlarms = prefs.getStringList('AlarmsList') ?? [];
      _loadedAlarms = loadedAlarms;
      for (String alarm in _loadedAlarms) {
        alarmsList.add(NewAlarm(time: alarm));
      }
      _alarmsList = alarmsList;
    });
  }

  Future<void> _addAlarm() async {
    final SharedPreferences prefs = await _prefs;
    final DateTime alarm = DateTime.now();
    final String formatedAlarm = "${alarm.hour}:${alarm.minute}";
    setState(() {
      _loadedAlarms.add(formatedAlarm);
      prefs.setStringList('AlarmsList', _loadedAlarms);
      _loadAlarms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: _alarmsList,
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 25, 20),
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            foregroundColor: CustomColors.screensFontColor,
            elevation: 15,
            onPressed: _addAlarm,
            child: const Icon(Icons.add_alarm),
          ),
        ),
      )
    ]);
  }
}
