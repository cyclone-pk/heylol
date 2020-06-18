import 'package:flutter/cupertino.dart';
import 'package:heylol/models/videos.dart';

class HomePageProvider extends ChangeNotifier {
  List<Video> _homePageVideos = [];

  bool _firstFetch = false;

  bool _isloading = false;

  get homePageVideos => _homePageVideos;
  get isLoading => _isloading;
  get firstFetch => _isloading;
  set isLoading(bool status) {
    _isloading = status;
  }

  set firstFetchFun(bool status) {
    _firstFetch = status;
  }

  void fetch5Videos() {
    if (!_firstFetch) {
      _firstFetch = true;
      //here we will call our api and grab 5 result from teh server;
      //add those video url to homepagevideo list;
      //if we don,t use thumbnail than we will get the first frame of the video
      // and use it as thumbnail for demo i use thumnail as i am not using video palyer

      _homePageVideos.addAll([
        Video(
            thumbnail:
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            videoUrl: "link3"),
        Video(
            thumbnail:
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            videoUrl: "link4"),
        Video(
            thumbnail:
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            videoUrl: "link5"),
        Video(
            thumbnail:
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            videoUrl: "link6"),
        Video(
            thumbnail:
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            videoUrl: "link8"),
      ]);
//    notifyListeners();
    }
  }

  void fetchMoreVideo() {
    _isloading = true;
    //once we reach end of last video and if the video swipe to next video
    //we will call this function and add additional 5 video to the last and this
    //way we will achive the infinite scroll  for each time we need new video
    //we will call our server .
    _homePageVideos.addAll([
      Video(
          thumbnail:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          videoUrl: "link3"),
      Video(
          thumbnail:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          videoUrl: "link4"),
      Video(
          thumbnail:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          videoUrl: "link5"),
      Video(
          thumbnail:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          videoUrl: "link6"),
      Video(
          thumbnail:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          videoUrl: "link8"),
    ]);
    _isloading = false;
  }
}
