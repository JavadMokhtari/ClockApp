import 'package:clock_app/screens/alarm_screen.dart';
import 'package:clock_app/screens/clock_screen.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/constants/colors.dart';
import '../screens/stopwatch_screen.dart';
import '../screens/timer_screen.dart';

class ClockAppBottomNavigationBar extends StatefulWidget {
  const ClockAppBottomNavigationBar({super.key});

  @override
  State<ClockAppBottomNavigationBar> createState() =>
      _ClockAppBottomNavigationBarState();
}

class _ClockAppBottomNavigationBarState
    extends State<ClockAppBottomNavigationBar> {
  _ClockAppBottomNavigationBarState();

  List screens = [
    const AlarmScreen(),
    const ClockScreen(),
    const StopwatchScreen(),
    const TimerScreen(),
  ];
  late int screenIndex;

  void _onItemTap(index) {
    screenIndex = index;
    setState(() {
      Navigator.push<void>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  screens[screenIndex](screenIndex)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
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
            currentIndex: screenIndex ?? 1,
            onTap: _onItemTap,
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
    );
  }
}
