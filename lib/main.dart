import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heylol/Provider/bottom_bar_navigation.dart';
import 'package:heylol/Provider/home_page_provider.dart';
import 'package:heylol/Provider/user_provider.dart';
import 'package:heylol/CustomMenuBar/bottom_navigation_bar.dart';
import 'package:heylol/Provider/video_player_provider.dart';
import 'package:provider/provider.dart';

import 'Provider/chats_provider.dart';
import 'Views/chats_view.dart';
import 'Views/home_page.dart';
import 'Views/profile_view.dart';
import 'constants.dart';
import 'models/trending_videos.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => BottomNavigationProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => VideoPlayerProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => HomePageProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ChatsProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).fetchUserData();
    TrendingVideos.fetchTrendingVideos();
    Provider.of<ChatsProvider>(context).fetchRecentChats();

    return MaterialApp(
      home: Scaffold(
          backgroundColor: kSecondaryColor,
          bottomNavigationBar: CustomNavigationBar(),
          body: MainWrapper()),
    );
  }
}

class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Menu _menu = Provider.of<BottomNavigationProvider>(context).selectedMenu;
    return _menu == Menu.user
        ? ProfileScreen()
        : _menu == Menu.chat ? ChatView() : HomePage();
  }
}
