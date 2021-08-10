import 'package:flutter/material.dart';
import 'package:make_me_code/models/realm_upgrades.dart';
import 'package:make_me_code/utils/storage_manager.dart';
import 'package:make_me_code/models/language_details.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';

class UpgradesProvider with ChangeNotifier {
  late RealmUpgrades realmUpgrades;

  UpgradesProvider() {
    // ! TODO:: load from localStorage

    realmUpgrades = RealmUpgrades();
    notifyListeners();
  }
}
