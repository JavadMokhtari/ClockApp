import 'package:clock_app/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Widget> _alarmsList = [];
  List<String> _loadedAlarms = [];
  bool alarmStatus = true;

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
      for (String alarmTime in _loadedAlarms) {
        alarmsList.add(newAlarm(time: alarmTime));
      }
      _alarmsList = alarmsList;
    });
  }

  Future<void> _addAlarm(BuildContext context) async {
    final TimeOfDay? pickedAlarm = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: "SET ALARM",
    );
    final SharedPreferences prefs = await _prefs;

    setState(() {
      if (pickedAlarm != null) {
        String alarmHour = pickedAlarm.hour.toString().padLeft(2, '0');
        String alarmMinute = pickedAlarm.minute.toString().padLeft(2, '0');
        _loadedAlarms.add("$alarmHour:$alarmMinute");
        prefs.setStringList('AlarmsList', _loadedAlarms);
      }
      _loadAlarms();
    });
  }

  void switchAlarm(bool status) {
    alarmStatus = status;
    setState(() {});
  }

  Widget newAlarm({required String time}) {
    bool alarmStatus = true;
    return Card(
      color: CustomColors.alarmCardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 20,
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        height: 60,
        width: 400,
        child: Center(
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              time,
              style: const TextStyle(
                color: CustomColors.foreground,
                fontSize: 20,
                letterSpacing: 3,
              ),
            ),
            trailing: Switch(
              value: alarmStatus,
              onChanged: switchAlarm,
              activeColor: CustomColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      // elevation: 10,
      appBar: AppBar(
        backgroundColor: CustomColors.background,
        foregroundColor: CustomColors.foreground,
        elevation: 0,
        title: ListTile(
          leading: _alarmsList.isEmpty
              ? const Text(
                  "All alarms are off",
                  style: TextStyle(
                    fontSize: 18,
                    color: CustomColors.foreground,
                    letterSpacing: 1,
                  ),
                )
              : const Text(
                  "Alarm in 3 hours 20 minutes",
                  style: TextStyle(
                    fontSize: 18,
                    color: CustomColors.foreground,
                    letterSpacing: 1,
                  ),
                ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
            color: CustomColors.foreground,
          ),
        ),
      ),
      body: Stack(children: [
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
              foregroundColor: CustomColors.foreground,
              elevation: 15,
              onPressed: () => _addAlarm(context),
              child: const Icon(Icons.add_alarm),
            ),
          ),
        ),
      ]),
    );
  }
}
