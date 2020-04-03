import 'package:finalproject/model/connection.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../controller/myfirebase.dart';
import '../view/mydialog.dart';
import '../view/frontpage.dart';
import 'package:flutter/material.dart';
import '../view/signuppage.dart';
import '../view/homepage.dart';
import '../model/user.dart';

class FrontPageController {
  FrontPageState state;

  FrontPageController(this.state);

        
  void createAccount() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
  }

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter valid Email address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter password';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }



  void login() async {
    print('Login called');
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();

    MyDialog.showProgressBar(state.context);

    try {
      state.user.uid = await MyFireBase.login(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      MyDialog.popProgressBar(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Login Error',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    try {
      User user = await MyFireBase.readProfile(state.user.uid);
      state.user.displayName = user.displayName;
      state.user.email = user.email;
      state.user.userType = user.userType;
      state.user.imageURL = user.imageURL;
      state.user.description = user.description;
      state.user.uid = user.uid;
      state.user.isNewMatch = user.isNewMatch;
      state.user.isNewLiked = user.isNewLiked;

      print('ImageURL: ' + user.imageURL);

      state.user.imageURL = await MyFireBase.getUserImage(state.user);

      print('ImageURL: ' + state.user.imageURL);


      //Creating match list
      state.user.matches = await MyFireBase.getMatches(state.user);
      print('Matches: ' + state.user.matches.length.toString());
      for (int i = 0; i < state.user.matches.length; i++) {
        User user = await MyFireBase.readProfile(state.user.matches[i].uid);
        state.user.matches[i].displayName = user.displayName;
        state.user.matches[i].email = user.email;
        state.user.matches[i].userType = user.userType;
        state.user.matches[i].imageURL = user.imageURL;
        state.user.imageURL = await MyFireBase.getUserImage(state.user.matches[i]);
        state.user.matches[i].description = user.description;
        state.user.matches[i].uid = user.uid;
        state.user.matches[i].isNewMatch = user.isNewMatch;
        state.user.matches[i].isNewLiked = user.isNewLiked;
        print('Initialize: ' + state.user.displayName);
      }

      //Creating Liked User list
      state.user.liked = await MyFireBase.getLikedUser(state.user);
      print('Liked User: ' + state.user.liked.length.toString());
      for (int i = 0; i < state.user.liked.length; i++) {
        User user = await MyFireBase.readProfile(state.user.liked[i].uid);
        state.user.liked[i].displayName = user.displayName;
        state.user.liked[i].email = user.email;
        state.user.liked[i].userType = user.userType;
        state.user.liked[i].imageURL = user.imageURL;
        state.user.imageURL = await MyFireBase.getUserImage(state.user.liked[i]);
        state.user.liked[i].description = user.description;
        state.user.liked[i].uid = user.uid;
        state.user.liked[i].isNewMatch = user.isNewMatch;
        state.user.liked[i].isNewLiked = user.isNewLiked;
      }
    } catch (e) {
      print('*****READPROFILE' + e.toString());
    }
    List<User> userlist;
    List<User> brandlist;
    List<User> influencerlist;
    List<Connection> swipedlist;

    try {
      userlist = await MyFireBase.getUsers();
      brandlist = await MyFireBase.getBrands();
      influencerlist = await MyFireBase.getInfluencers();
      swipedlist = await MyFireBase.getConnections(state.user);
      print('Flag**********************************************');
      for (int i = 1; i < brandlist.length; i++) {
        brandlist[i].imageURL = await MyFireBase.getUserImage(brandlist[i]);
        //print(brandlist[i].displayName + ': ' + brandlist[i].imageURL);
      }
      // for (var user in brandlist) {
      //   user.imageURL = await getUserImage(user);
      //   print(user.displayName + ': ' + user.imageURL);
      // }

      for (int i = 1; i < influencerlist.length; i++) {
        influencerlist[i].imageURL = await MyFireBase.getUserImage(influencerlist[i]);
        // print(
        //     influencerlist[i].displayName + ': ' + influencerlist[i].imageURL);
      }
      // for (var user in influencerlist) {
      //   user.imageURL = await getUserImage(user);
      //   print(user.displayName + ': ' + user.imageURL);
      // }
    } catch (e) {
      userlist = <User>[];
      brandlist = <User>[];
      influencerlist = <User>[];
      swipedlist = <Connection>[];
    }

    // Remove once the user swiped

    if (swipedlist != null) {
      //print('Connection List is not null!!!!!!!!!!!!');
      if (state.user.userType == 'Influencer') {
        for (int i = 0; i < brandlist.length; i++) {
          for (int j = 0; j < swipedlist.length; j++) {
            if (brandlist[i].uid == swipedlist[j].uid) {
              print(brandlist[i].displayName + ' is removed!!!!!!!!!!!!!!!!');
              //brandlist.removeAt(i);
            }
          }
        }
      }

      if (state.user.userType == 'Brand') {
        for (int i = 0; i < influencerlist.length; i++) {
          for (int j = 0; j < swipedlist.length; j++) {
            if (influencerlist[i].uid == swipedlist[j].uid) {
              print(influencerlist[i].displayName +
                  ' is removed!!!!!!!!!!!!!!!!');
              //influencerlist.removeAt(i);
            }
          }
        }
      }

      MyDialog.popProgressBar(state.context);

      MyDialog.info(
          context: state.context,
          title: 'Login Success',
          message: 'Press OK to navigate to homepage',
          action: () {
            Navigator.pop(state.context);
            Navigator.push(
                state.context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(state.user, userlist, brandlist, influencerlist),
                ));
          });
    }
  }
}
