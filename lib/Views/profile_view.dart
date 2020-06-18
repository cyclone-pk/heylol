import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heylol/Provider/bottom_bar_navigation.dart';
import 'package:heylol/Provider/user_provider.dart';
import 'package:heylol/models/videos.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen();
  var bottomPadding;
  @override
  Widget build(BuildContext context) {
    bottomPadding = Platform.isIOS
        ? MediaQuery.of(context).padding.top == 44.0 ? 34.0 : 0
        : 0.0;
    return SingleChildScrollView(
      child: Consumer2<UserProvider, BottomNavigationProvider>(
        builder: (context, userProvider, bottomNavigationProvider, child) {
          return GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity.compareTo(0) == -1) {
                bottomNavigationProvider.selectedMenu = Menu.home;
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      height: 270,
                      child: SafeArea(
                        bottom: false,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(bottom: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                child: Container(
                                  color: Colors.white,
                                  height: 92,
                                  width: 92,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: userProvider.profilePicUrl,
                                    placeholder: (context, url) => Container(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  kPrimaryColor),
                                        ))),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  userProvider.username,
                                  style: TextStyle(
                                      letterSpacing: -1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: 92,
                                child: ButtonTheme(
                                  padding: EdgeInsets.all(0),
                                  height: 24,
                                  child: RaisedButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {
                                      print(userProvider.favVideos);
                                    },
                                    focusElevation: 2.0,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kPrimaryColor),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: kPrimaryColor,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      color: kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Favourite Videos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: -1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        323 -
                        MediaQuery.of(context).padding.bottom -
                        MediaQuery.of(context).padding.top -
                        bottomPadding,
                    child: userProvider.favVideos.length > 0
                        ? GridView.count(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            childAspectRatio: .66,
                            crossAxisCount: 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            children: userProvider.favVideos
                                .map<Widget>(
                                    (vid) => ProfileVideoCard(video: vid))
                                .toList(),
                          )
                        : Center(
                            child: Text(
                              "You Don,t Have Any Favourite Videos.",
                              style: TextStyle(
                                  letterSpacing: -1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileVideoCard extends StatelessWidget {
  final Video video;
  ProfileVideoCard({this.video});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: video.thumbnail,
                placeholder: (context, url) => Container(
                    height: 30,
                    width: 30,
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ))),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, user, child) {
                return Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(3),
                          bottomLeft: Radius.circular(3))),
                  child: Dismissible(
                    direction: DismissDirection.startToEnd,
                    onDismissed: (dir) {
                      user.removeFromFav(video);
                    },
                    key: Key(video.videoUrl),
                    child: Container(
                      padding: EdgeInsets.only(left: 3),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.delete_sweep,
                          size: 15,
                          color: kTertiaryColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(3),
                              bottomLeft: Radius.circular(3))),
                      height: 17,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        width: 100,
        height: 150,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              offset: Offset(3, 0),
              blurRadius: 6,
              spreadRadius: .6),
        ]),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path customPath = Path();
    customPath.lineTo(0.0, 210);
    customPath.quadraticBezierTo(size.width / 2, 210 * 1.5, size.width, 210);
    customPath.lineTo(size.width, 0.0);
    customPath.close();
    return customPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
