import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heylol/Provider/bottom_bar_navigation.dart';
import 'package:heylol/Provider/home_page_provider.dart';

import 'package:heylol/Provider/video_player_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page.round();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<VideoPlayerProvider, HomePageProvider,
        BottomNavigationProvider>(
      builder: (context, videoPlayerProvider, homePageProvider,
          bottomNavigationProvider, child) {
        homePageProvider.fetch5Videos();

        return GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity.compareTo(0) == -1) {
              bottomNavigationProvider.selectedMenu = Menu.chat;
            }
            if (details.primaryVelocity.compareTo(0) == 1) {
              bottomNavigationProvider.selectedMenu = Menu.user;
            }
          },
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              if (currentPage == homePageProvider.homePageVideos.length - 1) {
                homePageProvider.fetchMoreVideo();
              }
              return homePageProvider.isLoading
                  ? Container(
                      height: 30,
                      width: 30,
                      child: Center(child: CircularProgressIndicator()))
                  : Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        VideoPlayerContainer(),
                        PlayPauseButton(
                          status: videoPlayerProvider.isVideoPlaying,
                          onPressPlay: () {
                            if (videoPlayerProvider.isVideoPlaying) {
                              //here we will also call videoplayer instance and call pause method of the player to pause the video
                              videoPlayerProvider.isVideoPlaying = false;
                            } else {
                              //here we will resume the video from video palyer instance
                              videoPlayerProvider.isVideoPlaying = true;
                            }
                          },
                        ),
                        InteractionButtons(
                          onPressShare: () {
                            Share.share(
                                "Watch This Amazing Video Right Now : " +
                                    homePageProvider
                                        .homePageVideos[index].videoUrl);
                            //this function will execute when share button is press
                          },
                          onPressFav: () {
                            //this function will execute when Heart button is press
                          },
                          onPressDownload: () {
                            //this function will execute when Download button is press
                          },
                        ),
                      ],
                    );
            },
            itemCount: homePageProvider.homePageVideos.length,
            scrollDirection: Axis.vertical,
          ),
        );
      },
    );
  }
}

class VideoPlayerContainer extends StatelessWidget {
  const VideoPlayerContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Here we will use Video Player In the Container to Show the Video I use Pic for Demo Purpose
    //TODO now By Deafult i set the isPlaying Value to False but we will make it true here in the video palyer once video start playing
    return Container(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl:
            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        placeholder: (context, url) => Container(
            height: 30,
            width: 30,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ))),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  final Function onPressPlay;
  final bool status;

  PlayPauseButton({@required this.onPressPlay, @required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        onPressed: onPressPlay,
        padding: EdgeInsets.all(0),
        child: Icon(
          status ? Icons.play_arrow : Icons.pause,
          color: kPrimaryColor,
          size: 70,
        ),
      ),
    );
  }
}

class InteractionButtons extends StatelessWidget {
  final Function onPressFav;
  final Function onPressShare;
  final Function onPressDownload;
  InteractionButtons(
      {@required this.onPressDownload,
      @required this.onPressFav,
      @required this.onPressShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.all(0),
            onPressed: onPressFav,
            child: Icon(
              Icons.favorite_border,
              color: kPrimaryColor,
              size: 40,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CupertinoButton(
            padding: EdgeInsets.all(0),
            onPressed: onPressShare,
            child: Icon(
              Icons.share,
              color: kPrimaryColor,
              size: 40,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CupertinoButton(
            padding: EdgeInsets.all(0),
            onPressed: onPressDownload,
            child: Icon(
              Icons.file_download,
              color: kPrimaryColor,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
