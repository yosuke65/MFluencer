import 'package:finalproject/controller/matchconfirmationscreen_controller.dart';
import 'package:finalproject/model/user.dart';
import 'package:flutter/material.dart';

class MatchConfirmationScreen extends StatefulWidget {
  final User user;
  final User matchedUser;
  MatchConfirmationScreen(this.user, this.matchedUser);

  @override
  State<StatefulWidget> createState() {
    return MatchConfirmationScreenState(user, matchedUser);
  }
}

class MatchConfirmationScreenState extends State {
  MatchConfirmationScreenController controller;
  User user;
  User matchedUser;


  MatchConfirmationScreenState(this.user, this.matchedUser) {
    controller = MatchConfirmationScreenController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
          0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(matchedUser.imageURL),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                controller.dismiss();
              },
              child: Container(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 2500),
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      'Match!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 600),
          child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  matchedUser.displayName,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 350),
                child: RawMaterialButton(
                  onPressed: () => controller.myMessages(), // Go to Chat
                  child: new Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 35.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 350),
                child: RawMaterialButton(
                  onPressed: () {
                    controller.dismiss();
                  },
                  child: new Icon(
                    Icons.exit_to_app,
                    color: Colors.blue,
                    size: 35.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
