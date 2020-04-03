import 'package:finalproject/model/user.dart';
import 'package:finalproject/view/matchconfirmationscreen.dart';
import 'package:finalproject/view/mymessages.dart';
import 'package:flutter/material.dart';

class MatchConfirmationScreenController {
  MatchConfirmationScreenState state;

  MatchConfirmationScreenController(this.state);

  void dismiss() {
    print('Dismiss called');
    Navigator.pop(state.context);
  }

  void myMessages() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => Messages(state.user, state.matchedUser),
        ));
  }
}
