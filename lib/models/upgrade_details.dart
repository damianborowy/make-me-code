import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upgrade_details.g.dart';

@JsonSerializable(explicitToJson: true)
class UpgradeDetails {
  @JsonKey(ignore: true)
  late IconData icon;

  late String name;
  late int level;

  @JsonKey(ignore: true)
  double? upgradeCost;

  @JsonKey(ignore: true)
  String? upgradePercentageProfit;

  UpgradeDetails({required this.name, required this.level});

  factory UpgradeDetails.fromJson(Map<String, dynamic> json) =>
      _$UpgradeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UpgradeDetailsToJson(this);
}
