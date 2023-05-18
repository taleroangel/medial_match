extension UnixTime on DateTime {
  /// Get as UTC Unix time
  int get unixTime => toUtc().millisecondsSinceEpoch ~/ 1000;

  /// Create local date time from Unix time
  static DateTime fromUnixTime(int unixTime) =>
      DateTime.fromMillisecondsSinceEpoch(unixTime * 1000).toLocal();
}
