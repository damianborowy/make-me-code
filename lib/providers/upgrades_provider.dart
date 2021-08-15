import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';
import 'package:make_me_code/models/realm_upgrades.dart';
import 'package:make_me_code/models/upgrade_count_enum.dart';

class UpgradesProvider with ChangeNotifier {
  late RealmUpgrades _realmUpgrades;
  UpgradeCount upgradeCount = UpgradeCount.SINGLE;

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

  Future<void> calculateEarnings(int delay) async {
    _realmUpgrades.realmUpgrades.entries.forEach((realmUpgradeEntry) {
      var newLinesOfCode = realmUpgradeEntry.value.linesOfCode;

      realmUpgradeEntry.value.upgrades.entries.forEach((languageUpgradesEntry) {
        newLinesOfCode = languageUpgradesEntry.value.fold(
            newLinesOfCode,
            (previousValue, upgrade) =>
                previousValue + (upgrade.linesOfCodePerLoop ?? 0));
      });

      realmUpgradeEntry.value.linesOfCodePerSecond =
          (newLinesOfCode - realmUpgradeEntry.value.linesOfCode) /
              (delay / 1000);
      realmUpgradeEntry.value.linesOfCode = newLinesOfCode;

      realmUpgradeEntry.value.upgrades.entries.forEach((languageUpgradesEntry) {
        languageUpgradesEntry.value.forEach((upgrade) {
          upgrade.deriveProperties(upgradeCount, newLinesOfCode);
        });
      });
    });

    notifyListeners();

    await _saveRealmUpgrades();
  }

  Future<void> levelUpUpgrade(
      Realm realm, Language language, int index, int delay) async {
    final languageDetails = _realmUpgrades.realmUpgrades[realm]!;
    final upgrade = languageDetails.upgrades[language]![index];

    languageDetails.linesOfCode -= (upgrade.upgradeCost ?? 0);

    upgrade.level = upgrade.levelAfterLeveledUp!;
    upgrade.calculateLinesOfCodePerLoop();
    upgrade.deriveProperties(upgradeCount, languageDetails.linesOfCode);

    double newLinesOfCodePerSecond = 0.0;

    languageDetails.upgrades.entries.forEach((languageUpgradesEntry) {
      newLinesOfCodePerSecond += languageUpgradesEntry.value
          .fold(0.0, (acc, upgrade) => acc + (upgrade.linesOfCodePerLoop ?? 0));
    });

    languageDetails.linesOfCodePerSecond = newLinesOfCodePerSecond;

    notifyListeners();

    await _saveRealmUpgrades();
  }

  Future<void> setUpgradeCount(UpgradeCount newUpgradeCount, int delay) async {
    upgradeCount = newUpgradeCount;

    await calculateEarnings(delay);
  }

  Future<void> _saveRealmUpgrades() async {
    final box = await Hive.openBox('upgradesProvider');
    await box.put('realmUpgrades', _realmUpgrades.toJson());
  }
}
