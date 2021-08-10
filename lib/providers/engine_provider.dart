import 'package:flutter/material.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';
import 'package:make_me_code/utils/enum_decode.dart';
import 'package:make_me_code/utils/storage_manager.dart';

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
  int _delay = 1000;
  Realm _selectedRealm = Realm.FRONTEND;
  Language _selectedLanguage = Language.HTML;

  int get delay => _delay;
  Realm get selectedRealm => _selectedRealm;
  Language get selectedLanguage => _selectedLanguage;

  EngineProvider() {
    StorageManager.readData('delay').then((value) {
      if (value != null) _delay = value;
    });

    StorageManager.readData('selectedRealm').then((value) {
      if (value != null) _selectedRealm = enumDecode(realmEnumMap, value);
    });

    StorageManager.readData('selectedLanguage').then((value) {
      if (value != null) _selectedLanguage = enumDecode(languageEnumMap, value);
    });

    notifyListeners();
  }

  void setDelay(int newDelay) async {
    _delay = newDelay;
    await StorageManager.saveData('delay', newDelay);
    notifyListeners();
  }

  void setSelectedRealm(Realm newSelectedRealm) async {
    _selectedRealm = newSelectedRealm;
    await StorageManager.saveData(
        'selectedRealm', realmEnumMap[newSelectedRealm]);
    notifyListeners();
  }

  void setSelectedLanguage(Language newSelectedLanguage) async {
    _selectedLanguage = newSelectedLanguage;
    await StorageManager.saveData(
        'selectedLanguage', languageEnumMap[newSelectedLanguage]);
    notifyListeners();
  }
}
