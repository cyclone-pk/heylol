import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:heylol/Provider/bottom_bar_navigation.dart';
import 'package:heylol/Provider/chats_provider.dart';
import 'package:heylol/models/trending_videos.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import '../constants.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, child) {
      return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity.compareTo(0) == 1) {
            bottomNavigationProvider.selectedMenu = Menu.home;
          }
        },
        child: Column(
          children: <Widget>[
            TrendingVideo(),
            RecentChats(),
          ],
        ),
      );
    });
  }
}

class RecentChats extends StatelessWidget {
  RecentChats();

  double bottomPadding = 0;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).padding.top);
    bottomPadding = Platform.isIOS
        ? MediaQuery.of(context).padding.top == 44.0 ? 34.0 : 0
        : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
          child: Text("Recent Chats",
              style: TextStyle(
                  letterSpacing: -1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
        ),
        Stack(
          children: <Widget>[
            Consumer<ChatsProvider>(
              builder: (context, chatsProvider, child) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  //i did thi smanual detection of ios with notch dislay to remove bottom padding which is not getting in bottom padding
                  height: (MediaQuery.of(context).size.height -
                          287 -
                          MediaQuery.of(context).padding.bottom -
                          MediaQuery.of(context).padding.top) -
                      bottomPadding,
                  child: chatsProvider.recentChat.length == 0
                      ? Center(
                          child: Text("You Have No Chat History",
                              style: TextStyle(
                                  letterSpacing: -1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor)),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: chatsProvider.recentChat.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              key: Key(
                                  chatsProvider.recentChat[index].senderPicUrl),
                              background: Container(
                                padding: EdgeInsets.only(right: 20),
                                color: kPrimaryColor,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Delete!",
                                      style: TextStyle(
                                          letterSpacing: -1,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kTertiaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              onDismissed: (dir) {
                                chatsProvider.chatRemove(
                                    chatsProvider.recentChat[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: chatsProvider
                                                  .recentChat[index]
                                                  .senderPicUrl,
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                kPrimaryColor),
                                                      ))),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                                chatsProvider.recentChat[index]
                                                    .senderName,
                                                style: TextStyle(
                                                    letterSpacing: -1,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimaryColor)),
                                            Text(
                                                chatsProvider.recentChat[index]
                                                    .lastmessage,
                                                style: TextStyle(
                                                    letterSpacing: -1,
                                                    fontSize: 14,
                                                    fontWeight: chatsProvider
                                                            .recentChat[index]
                                                            .read
                                                        ? FontWeight.bold
                                                        : FontWeight.w600,
                                                    color: kPrimaryColor)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      chatsProvider.recentChat[index].lastSeen,
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                );
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.chat,
                  color: kTertiaryColor,
                ),
                backgroundColor: kPrimaryColor,
              ),
            )
          ],
        )
      ],
    );
  }
}

class TrendingVideo extends StatelessWidget {
  const TrendingVideo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 240,
      child: SafeArea(
          bottom: false,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Trending Videos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: -1,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kTertiaryColor),
                  ),
                ),
                Container(
                  height: 145,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: TrendingVideos.trendingVideos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 20 : 10, top: 15, bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    offset: Offset(3, 0),
                                    blurRadius: 6,
                                    spreadRadius: .6)
                              ]),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: TrendingVideos
                                    .trendingVideos[index].thumbnail,
                                placeholder: (context, url) => Container(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kPrimaryColor),
                                    ))),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          )),
      width: double.infinity,
      color: kPrimaryColor,
    );
  }
}
