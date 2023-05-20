import 'package:flutter/material.dart';
import 'package:clock_app/settings/constants.dart';

TimePickerThemeData timePickerTheme() => TimePickerThemeData(
      backgroundColor: CustomColors.navigationBarBackground,
      hourMinuteTextColor: CustomColors.foreground,
      dialTextColor: CustomColors.foreground,
      dialBackgroundColor: CustomColors.alarmCardColor,
      dialHandColor: Colors.deepPurple,
      dayPeriodTextColor: CustomColors.foreground,
      entryModeIconColor: CustomColors.foreground,
      helpTextStyle: const TextStyle(
          color: CustomColors.foreground,
          fontFamily: "ubuntu",
          fontSize: 12,
          wordSpacing: 5),
      dayPeriodTextStyle: const TextStyle(
        color: CustomColors.foreground,
        fontFamily: "ubuntu",
      ),
      hourMinuteShape: const RoundedRectangleBorder(
        side: BorderSide(color: CustomColors.secondaryColor, width: 1),
      ),
      dayPeriodBorderSide:
          const BorderSide(color: CustomColors.secondaryColor, width: 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      hourMinuteColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? CustomColors.alarmCardColor
              : CustomColors.navigationBarBackground),
      dayPeriodColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? CustomColors.alarmCardColor
              : CustomColors.navigationBarBackground),
    );
