import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int index = -1;

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void _onBottomNavBarTap(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Dialog title'),
            content: Text('Index: ' + i.toString()),
            actions: <Widget>[
              TextButton(onPressed: _dismissDialog, child: Text('Close')),
              TextButton(onPressed: _dismissDialog, child: Text('Hello World!'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      backgroundColor: Theme.of(context).cardColor,
      snakeViewColor: Theme.of(context).cardColor,
      elevation: 4,
      currentIndex: index,
      onTap: _onBottomNavBarTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).iconTheme.color,
      unselectedItemColor: Theme.of(context).iconTheme.color,
      behaviour: SnakeBarBehaviour.floating,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      snakeShape: SnakeShape.indicator,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Realm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Gifts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Prestige',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        )
      ],
    );
  }
}
