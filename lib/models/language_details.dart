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

  static const upgradeIcons = {
    Realm.FRONTEND: {
      Language.HTML: [Icons.ac_unit, Icons.access_alarm]
    }
  };

  LanguageDetails({required this.realm, required this.linesOfCode}) {
    // ! TODO:: load from localStorage

    if (realm == Realm.FRONTEND) {
      upgrades = _getDefaultFrontendUpgrades();
    } else {
      upgrades = {};
    }

    _applyIcons(realm);
  }

  factory LanguageDetails.fromJson(Map<String, dynamic> json) =>
      _$LanguageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageDetailsToJson(this);

  void _applyIcons(Realm realm) {
    upgrades.entries.forEach((element) {
      upgrades[element.key] = element.value.mapIndexed((upgrade, index) {
        upgrade.icon = upgradeIcons[realm]![element.key]![index];
        return upgrade;
      }).toList();
    });
  }

  Map<Language, List<UpgradeDetails>> _getDefaultFrontendUpgrades() {
    return {
      Language.HTML: <UpgradeDetails>[
        UpgradeDetails(
          name: 'Some upgrade 1',
          level: 0,
        ),
        UpgradeDetails(
          name: 'Some upgrade 2',
          level: 0,
        ),
      ],
    };
  }
}
