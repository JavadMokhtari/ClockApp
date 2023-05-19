import 'package:clock_app/constants/constants.dart';
import 'package:flutter/material.dart';

class NewClock extends StatefulWidget {
  const NewClock({super.key});

  @override
  State<NewClock> createState() => _NewClockState();
}

class _NewClockState extends State<NewClock> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.alarmCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      margin: const EdgeInsets.all(5),
      child: const SizedBox(
        height: 70,
        width: 400,
        child: Center(
          child: ListTile(
            // contentPadding: EdgeInsets.all(20),
            title: Text.rich(
              TextSpan(
                text: "clock",
                style: TextStyle(
                  fontSize: 20,
                  color: CustomColors.foreground,
                  letterSpacing: 1,
                ),
                children: <InlineSpan>[
                  WidgetSpan(
                    child: SizedBox(width: 10),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.sunny,
                      color: CustomColors.foreground,
                    ),
                  )
                ],
              ),
            ),
            trailing: Text(
              "03:45",
              style: TextStyle(
                color: CustomColors.foreground,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
