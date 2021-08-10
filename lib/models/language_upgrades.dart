import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/models/languages.dart';
import 'package:make_me_code/models/upgrade_details.dart';

@JsonSerializable()
class LanguageUpgrades<T> {
  late Map<T, List<UpgradeDetails>> languageUpgrades;

  LanguageUpgrades() {
    // ! TODO:: load from localStorage

    if (T is FrontendLanguage) {
      languageUpgrades = {
        FrontendLanguage.HTML: <UpgradeDetails>[
          UpgradeDetails(
            icon: Icon(Icons.ac_unit),
            name: 'Some upgrade 1',
            level: 1,
          ),
          UpgradeDetails(
            icon: Icon(Icons.ac_unit),
            name: 'Some upgrade 2',
          ),
        ],
      } as Map<T, List<UpgradeDetails>>;
    } else {
      languageUpgrades = {};
    }
  }
}
