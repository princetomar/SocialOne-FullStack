import 'package:flutter/material.dart';

class FollowingDataProvider with ChangeNotifier {
  late bool isFollowing;

  FollowingDataProvider({this.isFollowing = false});

  void followUser() {
    isFollowing = true;
    notifyListeners();
  }

  void unfollowUser() {
    isFollowing = false;
    notifyListeners();
  }
}
