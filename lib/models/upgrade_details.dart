import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UpgradeDetails {
  late Icon icon;
  late String name;
  late int level;
  double? upgradeCost;
  String? upgradePercentageProfit;

  UpgradeDetails({required Icon icon, required String name, int? level}) {
    this.icon = icon;
    this.name = name;
    this.level = level ?? 0;
  }
}
