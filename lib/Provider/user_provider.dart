import 'package:flutter/cupertino.dart';
import 'package:heylol/models/videos.dart';

class UserProvider extends ChangeNotifier {
  String _username;
  String _profilePicUrl;
  List<Video> _favVideos;

  void fetchUserData() {
    //call api here to retrive data from server and set those data
    _username = "Zakria Khan";
    _profilePicUrl =
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    _favVideos = favVideoslist;
  }

  get username => _username;
  get profilePicUrl => _profilePicUrl;
  get favVideos => _favVideos;

  void removeFromFav(Video vid) {
    vid.markUnFav(vid);
    _favVideos.remove(vid);
//    fetchUserData();
    notifyListeners();
  }
}
