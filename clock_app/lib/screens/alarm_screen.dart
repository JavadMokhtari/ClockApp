import 'package:flutter/material.dart';
import 'package:clock_app/constants/colors.dart';
import 'package:clock_app/widgets/bottom_navigation_bar.dart';
import 'package:clock_app/utils/utils.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<Widget> alarmsList = <Widget>[];

  void addAlarm() {
    String newTime = "${DateTime.now().hour}:${DateTime.now().minute}";
    setState(() {
      Widget newAlarm = NewAlarm(time: newTime);
      alarmsList.add(newAlarm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      bottomNavigationBar: const ClockAppBottomNavigationBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          foregroundColor: CustomColors.screensFontColor,
          elevation: 15,
          onPressed: addAlarm,
          child: const Icon(Icons.add_alarm),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(children: alarmsList),
        ),
      ),
    );
  }
}
