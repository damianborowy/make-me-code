import 'package:flutter/foundation.dart';

enum UpgradeCount {
  SINGLE,
  ONE_PERCENT,
  TEN_PERCENT,
  FIFTY_PERCENT,
  MAX,
}

extension UpgradeCountExtension on UpgradeCount {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case UpgradeCount.SINGLE:
        return '1x';
      default:
        return '';
    }
  }
}
