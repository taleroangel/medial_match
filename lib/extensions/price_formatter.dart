import 'package:intl/intl.dart';

/// Price formatter
final priceFormat = NumberFormat("###,###,### \$");

extension PriceFormatter on double {
  /// Parse price into [priceFormat]
  String get asPrice => priceFormat.format(this);
}
