import 'package:finalproject/model/user.dart';
import 'package:finalproject/view/homepage.dart';
import 'package:finalproject/view/matchpage.dart';
import 'package:finalproject/view/profilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/view/mymessages.dart';

import 'myfirebase.dart';

class MatchPageController {
  MatchPageState state;
  User user;

  MatchPageController(this.state);

  void myMessages(User matchedUser) {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => Messages(state.user, matchedUser ),
        ));
  }

  void onTap(User matchedUser) {
        Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(matchedUser),
        ));
  }
}
