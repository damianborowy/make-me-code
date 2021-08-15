import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/extensions/iterable.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';
import 'package:make_me_code/models/upgrade_details.dart';

part 'language_details.g.dart';

@JsonSerializable(explicitToJson: true)
class LanguageDetails {
  late Map<Language, List<UpgradeDetails>> upgrades;
  late double linesOfCode;
  late Realm realm;

  @JsonKey(ignore: true)
  double? linesOfCodePerSecond;

  static const upgradeProperties = {
    Realm.FRONTEND: {
      Language.HTML: [
        {
          'icon': Icons.ac_unit,
          'baseCost': 5.0,
          'expBase': 1.1,
          'baseProductivity': 1.0,
          'multipliers': {25: 8.0, 50: 8.0, 100: 8.0, 150: 4.0, 200: 2.5}
        },
        {
          'icon': Icons.access_time,
          'baseCost': 40.0,
          'expBase': 1.13,
          'baseProductivity': 12.0,
          'multipliers': {25: 15.0, 50: 5.0, 100: 9.0, 150: 2.5}
        },
        {
          'icon': Icons.accessible,
          'baseCost': 720.0,
          'expBase': 1.14,
          'baseProductivity': 180.0,
          'multipliers': {25: 5.0, 50: 5.0, 100: 5.0}
        },
        {
          'icon': Icons.account_box,
          'baseCost': 8640.0,
          'expBase': 1.13,
          'baseProductivity': 1060.0,
          'multipliers': {25: 2.0, 50: 4.0, 100: 3.0}
        },
      ]
    }
  };

  LanguageDetails({required this.realm, required this.linesOfCode}) {
    if (realm == Realm.FRONTEND) {
      upgrades = _getDefaultFrontendUpgrades();
    } else {
      upgrades = {};
    }

    _applyProperties(realm);
  }

  factory LanguageDetails.fromJson(Map<String, dynamic> json) =>
      _$LanguageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageDetailsToJson(this);

  void _applyProperties(Realm realm) {
    upgrades.entries.forEach((element) {
      upgrades[element.key] = element.value.mapIndexed((upgrade, index) {
        upgrade.icon =
            upgradeProperties[realm]![element.key]![index]['icon']! as IconData;
        upgrade.baseCost = upgradeProperties[realm]![element.key]![index]
            ['baseCost']! as double;
        upgrade.expBase = upgradeProperties[realm]![element.key]![index]
            ['expBase']! as double;
        upgrade.baseProductivity =
            upgradeProperties[realm]![element.key]![index]['baseProductivity']!
                as double;
        upgrade.multipliers = upgradeProperties[realm]![element.key]![index]
            ['multipliers']! as Map<int, double>;

        upgrade.calculateLinesOfCodePerLoop();

        return upgrade;
      }).toList();
    });
  }

  Map<Language, List<UpgradeDetails>> _getDefaultFrontendUpgrades() {
    return {
      Language.HTML: <UpgradeDetails>[
        UpgradeDetails(
          name: 'Some upgrade 1',
          level: 1,
        ),
        UpgradeDetails(
          name: 'Some upgrade 2',
          level: 0,
        ),
      ],
    };
  }
}
