import 'package:clock_app/screens/clock_screen.dart';
import 'package:clock_app/screens/alarm_screen.dart';
import 'package:clock_app/screens/stopwatch_screen.dart';
import 'package:clock_app/screens/timer_screen.dart';
import 'package:clock_app/settings/themes.dart';
import 'package:flutter/material.dart';
import 'settings/constants.dart';

void main(List<String> args) {
  runApp(const ClockApp());
}

class ClockApp extends StatefulWidget {
  const ClockApp({super.key});

  @override
  State<ClockApp> createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  final List<Widget> _screens = [
    const AlarmScreen(),
    const ClockScreen(),
    const StopwatchScreen(),
    const TimerScreen(),
  ];
  int _screenIndex = 0;

  void _onTapBarItems(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "ubuntu",
        timePickerTheme: timePickerTheme(),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
                (states) => CustomColors.secondaryColor),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => CustomColors.alarmCardColor),
          ),
        ),
        dataTableTheme: const DataTableThemeData(
          headingTextStyle: TextStyle(
            fontFamily: "ubuntu",
            fontSize: 16,
            color: CustomColors.foreground,
          ),
          dataTextStyle: TextStyle(
            fontFamily: "ubuntu",
            fontSize: 14,
            color: CustomColors.foreground,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: CustomColors.background,
        body: _screens[_screenIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: CustomColors.navigationBarBackground,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.alarm),
                    label: "Alarm",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.av_timer_outlined),
                    label: "Clock",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.timer_10),
                    label: "StopWatch",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.timelapse),
                    label: "Timer",
                  ),
                ],
                currentIndex: _screenIndex,
                onTap: _onTapBarItems,
                backgroundColor: CustomColors.navigationBarBackground,
                type: BottomNavigationBarType.shifting,
                selectedItemColor: CustomColors.secondaryColor,
                unselectedItemColor: Colors.grey,
                selectedIconTheme: const IconThemeData(
                  color: CustomColors.secondaryColor,
                  size: 30,
                ),
                unselectedIconTheme:
                    const IconThemeData(color: Colors.grey, size: 25),
                selectedLabelStyle:
                    const TextStyle(fontFamily: "ubuntu", fontSize: 13),
                unselectedLabelStyle:
                    const TextStyle(fontFamily: "ubuntu", fontSize: 12),
                showUnselectedLabels: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
