import 'package:flutter/material.dart';
import 'package:heylol/Provider/bottom_bar_navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kTertiaryColor,
      child: SafeArea(
        bottom: true,
        top: false,
        child: Consumer<BottomNavigationProvider>(
          builder: (context, navigation, child) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      navigation.selectedMenu = Menu.user;
                    },
                    child: SvgPicture.asset(navigation.selectedMenu == Menu.user
                        ? "assets/svg/user_selected.svg"
                        : "assets/svg/user_unselected.svg"),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigation.selectedMenu = Menu.home;
                    },
                    child: SvgPicture.asset(navigation.selectedMenu == Menu.home
                        ? "assets/svg/home_selected.svg"
                        : "assets/svg/home_unselected.svg"),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigation.selectedMenu = Menu.chat;
                    },
                    child: SvgPicture.asset(navigation.selectedMenu == Menu.chat
                        ? "assets/svg/chat_selected.svg"
                        : "assets/svg/chat_unselected.svg"),
                  )
                ],
              ),
              height: 60,
              decoration: BoxDecoration(
                  color: kTertiaryColor,
                  border: Border(top: BorderSide(color: kPrimaryColor))),
            );
          },
        ),
      ),
    );
  }
}
