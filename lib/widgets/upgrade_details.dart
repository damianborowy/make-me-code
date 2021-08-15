import 'package:flutter/material.dart';
import 'package:make_me_code/models/upgrade_details.dart' as model;
import 'package:make_me_code/providers/engine_provider.dart';
import 'package:make_me_code/providers/upgrades_provider.dart';
import 'package:make_me_code/utils/number_prettifier.dart';
import 'package:provider/provider.dart';

class UpgradeDetails extends StatefulWidget {
  final model.UpgradeDetails upgradeDetailsModel;
  final int upgradeIndex;

  const UpgradeDetails(
      {Key? key, required this.upgradeDetailsModel, required this.upgradeIndex})
      : super(key: key);

  @override
  _UpgradeDetailsState createState() => _UpgradeDetailsState();
}

class _UpgradeDetailsState extends State<UpgradeDetails> {
  @override
  Widget build(BuildContext context) {
    final selectedRealm = context.watch<EngineProvider>().selectedRealm;
    final selectedLanguage = context.watch<EngineProvider>().selectedLanguage;
    final linesOfCode = context
        .watch<UpgradesProvider>()
        .realmUpgrades
        .realmUpgrades[selectedRealm]!
        .linesOfCode;
    final delay = context.watch<EngineProvider>().delay;

    return Container(
        child: Row(
      children: [
        Column(
          children: [
            Container(
              child: Icon(widget.upgradeDetailsModel.icon),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
            ),
            Container(
                child: Text(prettifyNumber(widget.upgradeDetailsModel.level)))
          ],
        ),
        Container(
          child: Column(
            children: [
              Text(widget.upgradeDetailsModel.name),
              Text(prettifyNumber(
                      widget.upgradeDetailsModel.linesOfCodePerLoop) +
                  (widget.upgradeDetailsModel.upgradePercentageProfit
                      .toString())),
              ElevatedButton(
                onPressed: widget.upgradeDetailsModel.upgradeCost != null &&
                        linesOfCode > widget.upgradeDetailsModel.upgradeCost!
                    ? () => context.read<UpgradesProvider>().levelUpUpgrade(
                        selectedRealm,
                        selectedLanguage,
                        widget.upgradeIndex,
                        delay)
                    : null,
                child: Text(
                    prettifyNumber(widget.upgradeDetailsModel.upgradeCost)),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
