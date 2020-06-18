import 'package:heylol/models/videos.dart';

class TrendingVideos {
  static List<Video> _trendingVideos;

  static get trendingVideos => _trendingVideos;

  static void fetchTrendingVideos() {
    //after fetching Trending Video and decoding json assign it in variable
    _trendingVideos = dummyTrendingVideos;
  }
}

var dummyTrendingVideos = [
  Video(
      thumbnail:
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      videoUrl: "link1"),
  Video(
      thumbnail:
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      videoUrl: "link2"),
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
];
