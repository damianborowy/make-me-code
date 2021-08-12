import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:make_me_code/models/realm_upgrades.dart';

class UpgradesProvider with ChangeNotifier {
  late RealmUpgrades _realmUpgrades;

  RealmUpgrades get realmUpgrades => _realmUpgrades;

  UpgradesProvider._create({Map<String, dynamic>? realmUpgrades}) {
    _realmUpgrades = realmUpgrades != null
        ? RealmUpgrades.fromJson(realmUpgrades)
        : _realmUpgrades = RealmUpgrades();

    notifyListeners();
  }

  static Future<UpgradesProvider> create() async {
    final box = await Hive.openBox('upgradesProvider');

    final storedRealmUpgrades = await box.get('realmUpgrades');

    return UpgradesProvider._create(realmUpgrades: storedRealmUpgrades);
  }

  void setRealmUpgrades(RealmUpgrades newRealmUpgrades) async {
    _realmUpgrades = newRealmUpgrades;
    notifyListeners();

    final box = await Hive.openBox('upgradesProvider');
    await box.put('realmUpgrades', newRealmUpgrades.toJson());
  }
}
