import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:make_me_code/models/language_enum.dart';
import 'package:make_me_code/models/realm_enum.dart';
import 'package:make_me_code/providers/engine_provider.dart';
import 'package:make_me_code/providers/theme_provider.dart';
import 'package:make_me_code/providers/upgrades_provider.dart';
import 'package:make_me_code/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final upgradesProvider = await UpgradesProvider.create();
  final themeProvider = await ThemeProvider.create();
  final engineProvider = await EngineProvider.create();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => themeProvider,
      ),
      ChangeNotifierProvider(
        create: (_) => upgradesProvider,
      ),
      ChangeNotifierProvider(
        create: (_) => engineProvider,
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make me code',
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: context.watch<ThemeProvider>().themeMode,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  int? _delay;

  Timer _setupTimer() {
    if (_delay == null) {
      _delay = context.read<EngineProvider>().delay;
    }

    return Timer.periodic(new Duration(milliseconds: _delay!), (timer) {
      final stopwatch = Stopwatch()..start();

      // const newUpgrades: AllUpgrades = JSON.parse(JSON.stringify(allUpgrades));
      // const newRealmsEconomies: AllRealmsEconomies = JSON.parse(JSON.stringify(allRealmsEconomies));

      // Object.entries(allUpgrades).forEach(([realm, realmUpgrades]) => {
      //   Object.entries(realmUpgrades).forEach(([language, upgrades]) => {
      //     const sumOfNewLines = upgrades.reduce((acc, upgrade) => acc + (upgrade.production || 0), 0);

      //     newRealmsEconomies[realm][language] += sumOfNewLines;
      //   });
      // });

      // setAllUpgrades(newUpgrades);
      // setAllRealmsEconomies(newRealmsEconomies);

      final realmUpgrades =
          context.read<UpgradesProvider>().realmUpgrades.realmUpgrades;

      final delay = context.read<EngineProvider>().delay;

      if (delay != _delay) {
        _delay = delay;
        _timer?.cancel();
        _timer = _setupTimer();
      }

      print('Game loop took ${stopwatch.elapsed.inMilliseconds}ms');
    });
  }

  @override
  void initState() {
    super.initState();

    _timer = _setupTimer();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 40,
            flexibleSpace: SafeArea(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Text('money'), Text('prestige'), Text('paid')],
                ),
              ),
            )),
        body: Column(
          children: [
            TextButton(
              child: Text('click'),
              onPressed: () => context
                  .read<EngineProvider>()
                  .setDelay(context.read<EngineProvider>().delay ~/ 2),
            ),
            Text(context.watch<EngineProvider>().delay.toString()),
            Text(context.watch<EngineProvider>().selectedLanguage.name),
            Text(context.watch<EngineProvider>().selectedRealm.name)
          ],
        ),
        bottomNavigationBar: MyBottomNavBar());
  }
}
