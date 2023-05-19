extension DurationToString on Duration {
  String toTimerString() {
    String m = inMinutes.toString().padLeft(2, '0');
    String s = inSeconds.toString().padLeft(2, '0');
    String ms = inMilliseconds.toString().padLeft(5, '0').substring(2);
    return "$m:$s:$ms";
  }
}

extension StringToDuration on String {
  int toInt() {
    return int.parse(this);
  }

  Duration toTimerDuration() {
    return Duration(
        minutes: substring(0, 2).toInt(),
        seconds: substring(3, 5).toInt(),
        milliseconds: substring(6, 9).toInt());
  }
}

int toSecond({required int hour, required int minute, required int second}) =>
    hour * 24 + minute * 60 + second;

String countToTime(int duration) {
  String hour = (duration ~/ 3600).toString().padLeft(2, '0');
  String minute = ((duration % 3600) ~/ 60).toString().padLeft(2, '0');
  String second = (duration % 3600 % 60).toString().padLeft(2, '0');

  return "$hour:$minute:$second";
}
