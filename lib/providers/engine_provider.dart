import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';
import 'package:make_me_code/utils/enum_decode.dart';

const realmEnumMap = {
  Realm.FRONTEND: 'FRONTEND',
};

const languageEnumMap = {
  Language.HTML: 'HTML',
  Language.CSS: 'CSS',
  Language.JAVASCRIPT: 'JAVASCRIPT',
  Language.TYPESCRIPT: 'TYPESCRIPT',
};

class EngineProvider with ChangeNotifier {
  late int _delay;
  late Realm _selectedRealm;
  late Language _selectedLanguage;

  int get delay => _delay;
  Realm get selectedRealm => _selectedRealm;
  Language get selectedLanguage => _selectedLanguage;

  EngineProvider._create(
      {int? delay, String? selectedRealm, String? selectedLanguage}) {
    _delay = delay ?? 1000;

    _selectedRealm = selectedRealm != null
        ? enumDecode(realmEnumMap, selectedRealm)
        : Realm.FRONTEND;

    _selectedLanguage = selectedLanguage != null
        ? enumDecode(languageEnumMap, selectedLanguage)
        : _selectedLanguage = Language.HTML;

    notifyListeners();
  }

  static Future<EngineProvider> create() async {
    final box = await Hive.openBox('engineProvider');

    final storedDelay = await box.get('delay');
    final storedSelectedRealm = await box.get('selectedRealm');
    final storedSelectedLanguage = await box.get('selectedLanguage');

    return EngineProvider._create(
        delay: storedDelay,
        selectedRealm: storedSelectedRealm,
        selectedLanguage: storedSelectedLanguage);
  }

  void setDelay(int newDelay) async {
    _delay = newDelay;
    notifyListeners();

    final box = await Hive.openBox('engineProvider');
    await box.put('delay', newDelay);
  }

  void setSelectedRealm(Realm newSelectedRealm) async {
    _selectedRealm = newSelectedRealm;
    notifyListeners();

    final box = await Hive.openBox('engineProvider');
    await box.put('selectedRealm', realmEnumMap[newSelectedRealm]);
  }

  void setSelectedLanguage(Language newSelectedLanguage) async {
    _selectedLanguage = newSelectedLanguage;
    notifyListeners();

    final box = await Hive.openBox('engineProvider');
    await box.put('selectedLanguage', languageEnumMap[newSelectedLanguage]);
  }
}
