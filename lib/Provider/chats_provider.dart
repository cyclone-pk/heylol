import 'package:flutter/material.dart';
import 'package:heylol/models/chat.dart';

class ChatsProvider extends ChangeNotifier {
  bool _isfetched = false;
  List<Chat> _recentsChats = [];

  fetchRecentChats() {
    if (!_isfetched) {
      _isfetched = true;
      _recentsChats = dummychats;
    }
  }

  chatRemove(Chat chat) {
    print(_recentsChats);
    _recentsChats.remove(chat);
    print(_recentsChats);

    notifyListeners();
  }

  get recentChat => _recentsChats;
}

List<Chat> dummychats = [
  Chat(
      senderPicUrl: "https://picsum.photos/200.jpg",
      lastSeen: "23 M",
      lastmessage: "Hey Nice Video",
      read: true,
      senderName: "QASIM cr"),
  Chat(
      senderPicUrl: "https://picsum.photos/250.jpg",
      lastSeen: "22 M",
      lastmessage: "Hey good Video",
      read: true,
      senderName: "arsalan "),
  Chat(
      senderPicUrl: "https://picsum.photos/300.jpg",
      lastSeen: "Active Now",
      lastmessage: "have a nice day.",
      read: true,
      senderName: "ihsan khan"),
  Chat(
      senderPicUrl: "https://picsum.photos/350.jpg",
      lastSeen: "13 M",
      lastmessage: "Hey Nice Video",
      read: false,
      senderName: "farooq khan"),
  Chat(
      senderPicUrl: "https://picsum.photos/340.jpg",
      lastSeen: "2 M",
      lastmessage: "Hey good Video",
      read: true,
      senderName: "sudais"),
  Chat(
      senderPicUrl: "https://picsum.photos/510.jpg",
      lastSeen: "6 M",
      lastmessage: "have a nice day.",
      read: true,
      senderName: "yahya khan"),
];
