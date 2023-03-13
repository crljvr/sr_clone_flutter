import 'package:intl/intl.dart';

enum DateTimeFormat { yyyyMMdd, jm }

extension DateTimeExtension on DateTime {
  String format(DateTimeFormat format) {
    switch (format) {
      case DateTimeFormat.yyyyMMdd:
        final formatter = DateFormat('yyyy-MM-dd');
        return formatter.format(this);
      case DateTimeFormat.jm:
        final formatter = DateFormat('jm');
        return formatter.format(this);
    }
  }
}
