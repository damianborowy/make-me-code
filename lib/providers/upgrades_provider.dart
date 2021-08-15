import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:make_me_code/models/realm_upgrades.dart';
import 'package:make_me_code/models/upgrade_count_enum.dart';

class UpgradesProvider with ChangeNotifier {
  late RealmUpgrades _realmUpgrades;
  UpgradeCount _upgradeCount = UpgradeCount.SINGLE;

  RealmUpgrades get realmUpgrades => _realmUpgrades;
  UpgradeCount get upgradeCount => _upgradeCount;

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
          upgrade.deriveProperties(_upgradeCount, newLinesOfCode);
        });
      });
    });

    notifyListeners();

    await _saveRealmUpgrades();
  }

  Future<void> levelUpUpgrade() async {}

  Future<void> _saveRealmUpgrades() async {
    final box = await Hive.openBox('upgradesProvider');
    await box.put('realmUpgrades', _realmUpgrades.toJson());
  }
}
