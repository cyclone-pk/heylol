import 'package:flutter/material.dart';

enum Menu { home, chat, user }

class BottomNavigationProvider extends ChangeNotifier {
  Menu _menu = Menu.home;

  set selectedMenu(Menu menu) {
    _menu = menu;
    notifyListeners();
  }

  get selectedMenu => _menu;
}
