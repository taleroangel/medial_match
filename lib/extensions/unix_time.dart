extension UnixTime on DateTime {
  /// Get as UTC Unix time
  int get unixTime => toUtc().millisecondsSinceEpoch ~/ 1000;
}

extension IntUnixTime on int {
  /// Create local date time from Unix time
  DateTime get asUnixTime =>
      DateTime.fromMillisecondsSinceEpoch(this * 1000).toLocal();
}
