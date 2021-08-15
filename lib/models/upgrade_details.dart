import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/models/upgrade_count_enum.dart';
import 'package:make_me_code/utils/number_prettifier.dart';

part 'upgrade_details.g.dart';

@JsonSerializable(explicitToJson: true)
class UpgradeDetails {
  late String name;
  late double level;

  @JsonKey(ignore: true)
  late IconData icon;

  @JsonKey(ignore: true)
  late double baseCost;

  @JsonKey(ignore: true)
  late double expBase;

  @JsonKey(ignore: true)
  late double baseProductivity;

  @JsonKey(ignore: true)
  late Map<int, double> multipliers;

  @JsonKey(ignore: true)
  double? linesOfCodePerLoop;

  @JsonKey(ignore: true)
  double? upgradeCost;

  @JsonKey(ignore: true)
  double? levelAfterLeveledUp;

  @JsonKey(ignore: true)
  String? upgradePercentageProfit;

  UpgradeDetails({required this.name, required this.level});

  factory UpgradeDetails.fromJson(Map<String, dynamic> json) =>
      _$UpgradeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UpgradeDetailsToJson(this);

  void calculateLinesOfCodePerLoop() {
    linesOfCodePerLoop = _calculateLinesOfCodePerLoop(level);
  }

  double _calculateLinesOfCodePerLoop(double level) {
    return level *
        baseProductivity *
        multipliers.entries.fold(1, (acc, multiplier) {
          if (level >= multiplier.key) {
            return acc * multiplier.value;
          } else {
            return acc;
          }
        });
  }

  void deriveProperties(UpgradeCount upgradeCount, double linesOfCode) {
    final maxPossibleUpgrades = _calculateMaxUpgrade(linesOfCode);
    double levelAfterUpgrade;

    switch (upgradeCount) {
      case UpgradeCount.SINGLE:
        levelAfterUpgrade = level + 1;
        break;
      case UpgradeCount.ONE_PERCENT:
        levelAfterUpgrade = (maxPossibleUpgrades / 100).roundToDouble();
        break;
      case UpgradeCount.TEN_PERCENT:
        levelAfterUpgrade = (maxPossibleUpgrades / 10).roundToDouble();
        break;
      case UpgradeCount.FIFTY_PERCENT:
        levelAfterUpgrade = (maxPossibleUpgrades / 2).roundToDouble();
        break;
      case UpgradeCount.MAX:
        levelAfterUpgrade = maxPossibleUpgrades;
    }

    levelAfterUpgrade = max(levelAfterUpgrade, level);

    levelAfterLeveledUp = levelAfterUpgrade;
    upgradeCost = baseCost *
        (pow(expBase, level) * (pow(expBase, levelAfterUpgrade) - 1)) /
        (expBase - 1);

    final linesOfCodeAfterUpgrade =
        _calculateLinesOfCodePerLoop(levelAfterUpgrade);

    upgradePercentageProfit = linesOfCodePerLoop != 0.0
        ? "+" +
            prettifyNumber(
                ((linesOfCodeAfterUpgrade / (linesOfCodePerLoop ?? 1)) - 1) *
                    100) +
            " %"
        : "";
  }

  double _calculateMaxUpgrade(double linesOfCode) {
    return log((((linesOfCode * (expBase - 1)) /
                    (baseCost * pow(expBase, level))) +
                1) /
            log(expBase))
        .roundToDouble();
  }
}
