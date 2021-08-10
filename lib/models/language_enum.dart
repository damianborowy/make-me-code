import 'package:flutter/foundation.dart';

enum Language {
  HTML,
  CSS,
  JAVASCRIPT,
  TYPESCRIPT,
}

extension FrontendLanguageExtension on Language {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case Language.HTML:
        return 'HTML';
      default:
        return '';
    }
  }
}
