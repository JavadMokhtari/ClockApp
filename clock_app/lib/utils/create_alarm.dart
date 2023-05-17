import 'package:flutter/material.dart';
import 'package:clock_app/constants/constants.dart';

class NewAlarm extends StatefulWidget {
  final String time;
  const NewAlarm({required this.time, super.key});

  @override
  State<NewAlarm> createState() => _NewAlarmState();
}

class _NewAlarmState extends State<NewAlarm> {
  bool alarmStatus = true;

  void switchAlarm(bool status) {
    alarmStatus = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.alarmCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        height: 60,
        width: 400,
        child: Center(
          child: ListTile(
            title: Text(
              widget.time,
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
}
