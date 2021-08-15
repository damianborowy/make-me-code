import 'package:flutter/material.dart';
import 'package:make_me_code/models/upgrade_count_enum.dart';
import 'package:make_me_code/providers/engine_provider.dart';
import 'package:make_me_code/providers/upgrades_provider.dart';
import 'package:make_me_code/widgets/upgrade_details.dart';
import 'package:provider/provider.dart';
import 'package:make_me_code/extensions/iterable.dart';

class UpgradesPanel extends StatefulWidget {
  const UpgradesPanel({Key? key}) : super(key: key);

  @override
  _UpgradesPanelState createState() => _UpgradesPanelState();
}

class _UpgradesPanelState extends State<UpgradesPanel> {
  void _handleUpgradesCountChange() {
    final upgradesCount = context.read<UpgradesProvider>().upgradeCount;
    final delay = context.read<EngineProvider>().delay;

    final newUpgradeCountIndex =
        upgradesCount.index + 1 == UpgradeCount.values.length
            ? 0
            : upgradesCount.index + 1;

    context
        .read<UpgradesProvider>()
        .setUpgradeCount(UpgradeCount.values[newUpgradeCountIndex], delay);
  }

  @override
  Widget build(BuildContext context) {
    final upgradesCount = context.watch<UpgradesProvider>().upgradeCount;
    final upgradesList = context
        .watch<UpgradesProvider>()
        .realmUpgrades
        .realmUpgrades[context.watch<EngineProvider>().selectedRealm]!
        .upgrades[context.watch<EngineProvider>().selectedLanguage]!;

    return Container(
      child: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: _handleUpgradesCountChange,
              child: Text(upgradesCount.displayTitle)),
          ...upgradesList
              .mapIndexed((upgrade, index) => UpgradeDetails(
                    upgradeDetailsModel: upgrade,
                    upgradeIndex: index,
                  ))
              .toList()
        ],
      ),
    );
  }
}
