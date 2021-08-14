import 'package:flutter/material.dart';
import 'package:make_me_code/providers/engine_provider.dart';
import 'package:make_me_code/providers/upgrades_provider.dart';
import 'package:make_me_code/widgets/upgrade_details.dart';
import 'package:provider/provider.dart';

class UpgradesPanel extends StatefulWidget {
  const UpgradesPanel({Key? key}) : super(key: key);

  @override
  _UpgradesPanelState createState() => _UpgradesPanelState();
}

class _UpgradesPanelState extends State<UpgradesPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ...context
              .watch<UpgradesProvider>()
              .realmUpgrades
              .realmUpgrades[context.watch<EngineProvider>().selectedRealm]!
              .upgrades[context.watch<EngineProvider>().selectedLanguage]!
              .map((upgrade) => UpgradeDetails())
              .toList()
        ],
      ),
    );
  }
}
