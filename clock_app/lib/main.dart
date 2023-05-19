import 'package:clock_app/screens/clock_screen.dart';
import 'package:clock_app/screens/alarm_screen.dart';
import 'package:clock_app/screens/stopwatch_screen.dart';
import 'package:clock_app/screens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'constants/constants.dart';

void main(List<String> args) {
  runApp(const ClockHomePage());
}

class ClockHomePage extends StatefulWidget {
  const ClockHomePage({super.key});

  @override
  State<ClockHomePage> createState() => _ClockHomePageState();
}

class _ClockHomePageState extends State<ClockHomePage> {
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
          )),
      home: Scaffold(
        backgroundColor: CustomColors.background,
        // floatingActionButton: _screenIndex == 0,
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
