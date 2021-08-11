import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:make_me_code/models/realm_upgrades.dart';
import 'package:make_me_code/utils/storage_manager.dart';
import 'package:make_me_code/models/language_details.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';

class UpgradesProvider with ChangeNotifier {
  RealmUpgrades _realmUpgrades = RealmUpgrades();

  RealmUpgrades get realmUpgrades => _realmUpgrades;

  UpgradesProvider() {
    StorageManager.readData('realmUpgrades').then((value) {
      if (value != null)
        _realmUpgrades = RealmUpgrades.fromJson(jsonDecode(value));
    });

    notifyListeners();
  }

  void setRealmUpgrades(RealmUpgrades newRealmUpgrades) async {
    _realmUpgrades = newRealmUpgrades;
    await StorageManager.saveData(
        'realmUpgrades', jsonEncode(newRealmUpgrades.toJson()));
    notifyListeners();
  }
}
