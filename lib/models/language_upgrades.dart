import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/models/languages.dart';
import 'package:make_me_code/models/realms.dart';
import 'package:make_me_code/models/upgrade_details.dart';

@JsonSerializable()
class LanguageDetails {
  late Map<Language, List<UpgradeDetails>> upgrades;
  late double linesOfCode;

  LanguageDetails(Realm realm) {
    // ! TODO:: load from localStorage

    if (realm == Realm.FRONTEND) {
      upgrades = {
        Language.HTML: <UpgradeDetails>[
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
      };
    } else {
      upgrades = {};
      linesOfCode = 0;
    }
  }
}
