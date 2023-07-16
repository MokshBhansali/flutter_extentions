extension DurationExtension on Duration {
  String get durationToString {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    if (inHours == 0 && inMinutes == 0) return '0:$twoDigitSeconds';
    if (inHours == 0) return '$twoDigitMinutes:$twoDigitSeconds';
    return "${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
