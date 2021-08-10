import 'package:flutter/material.dart';
import 'package:make_me_code/models/realm_upgrades.dart';
import 'package:make_me_code/utils/storage_manager.dart';
import 'package:make_me_code/models/language_upgrades.dart';
import 'package:make_me_code/models/languages.dart';
import 'package:make_me_code/models/realms.dart';

final defaultRealmUpgrades = {
  Realm.FRONTEND: LanguageDetails(Realm.FRONTEND),
};

class UpgradesProvider with ChangeNotifier {
  Map<Realm, LanguageDetails> realmUpgrades = {};

  UpgradesProvider() {
    // ! TODO:: load from localStorage

    realmUpgrades = defaultRealmUpgrades;
    notifyListeners();
  }
}
