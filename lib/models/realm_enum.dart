import 'package:flutter/foundation.dart';

enum Realm {
  FRONTEND,
}

extension RealmExtension on Realm {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case Realm.FRONTEND:
        return 'Frontend';
      default:
        return '';
    }
  }
}
