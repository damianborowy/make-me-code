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
      case UpgradeCount.ONE_PERCENT:
        return '1%';
      case UpgradeCount.TEN_PERCENT:
        return '10%';
      case UpgradeCount.FIFTY_PERCENT:
        return '50%';
      case UpgradeCount.MAX:
        return 'MAX';
      default:
        return '';
    }
  }
}
