import 'package:flutter/material.dart';
import 'package:make_me_code/models/languages.dart';
import 'package:make_me_code/providers/theme_provider.dart';
import 'package:make_me_code/providers/upgrades_provider.dart';
import 'package:make_me_code/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UpgradesProvider(),
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
  void foo() {
    context.read<UpgradesProvider>().realmUpgrades.entries.forEach((element) {
      print(element.value.languageUpgrades);
    });
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
        body: Row(
          children: [
            Container(
              child: TextButton(
                onPressed: foo,
                child: Text('Sus'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: MyBottomNavBar());
  }
}
