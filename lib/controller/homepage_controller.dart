import 'package:finalproject/model/connection.dart';
import 'package:finalproject/model/user.dart';
import 'package:finalproject/view/likeduserpage.dart';
import 'package:finalproject/view/matchconfirmationscreen.dart';
import 'package:finalproject/view/matchpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../view/homepage.dart';
import '../view/profilepage.dart';

class HomePageController {
  HomePageState state;
  User user;

  HomePageController(this.state);

  void signOut() {
    MyFireBase.signOut();
    Navigator.pop(state.context);
    Navigator.pop(state.context);
  }

  void swipeLeft(User swipedUser) {
    MyFireBase.swipLeft(state.user, swipedUser);
  }

  void swipeRight(User swipedUser) {
    print('swipeRight is called');
    MyFireBase.swipRight(state.user, swipedUser);
    swipedUser.isNewLiked = true;
    MyFireBase.updateInfo(swipedUser);
  }

  void isMatch(User swipedUser, BuildContext context) async {
    print('isMatch is called');
    Connection connection = await MyFireBase.isMatch(state.user, swipedUser);
    if (connection != null) {
      if (connection.yap) {
        //Match
        print('MATCH!!!!!!!!');

        MyFireBase.registerMatch(state.user, swipedUser);

        state.stateChanged(() {
          state.user.isNewMatch = true;
        });

        state.user.matches = await MyFireBase.getMatches(state.user);

        for (int i = 0; i < state.user.matches.length; i++) {
          User user = await MyFireBase.readProfile(state.user.matches[i].uid);
          state.user.matches[i].displayName = user.displayName;
          state.user.matches[i].email = user.email;
          state.user.matches[i].userType = user.userType;
          state.user.matches[i].imageURL = user.imageURL;
          state.user.matches[i].description = user.description;
          state.user.matches[i].uid = user.uid;
        }

        state.user.isNewMatch = true;
        MyFireBase.updateInfo(state.user);
        swipedUser.isNewMatch = true;
        MyFireBase.updateInfo(swipedUser);

        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                MatchConfirmationScreen(state.user, swipedUser)));
      }
    }
  }
  // void addButton() async {
  //   Book b = await Navigator.push(
  //       state.context,
  //       MaterialPageRoute(
  //         builder: (context) => BookPage(state.user, null),
  //       ));
  //   if (b != null) {
  //     state.booklist.add(b);
  //   } else {}
  // }

  // void onTap(int index) async {
  //   if (state.deleteindices == null) {
  //     Book b = await Navigator.push(
  //       state.context,
  //       MaterialPageRoute(
  //           builder: (context) => BookPage(state.user, state.booklist[index])),
  //     );

  //     if (b != null) {
  //       state.booklist[index] = b;
  //     }
  //   } else {
  //     if(state.deleteindices.contains(index)) {
  //       //tapped agian => deselect
  //       state.deleteindices.remove(index);
  //       if(state.deleteindices.length == 0) {
  //         state.deleteindices = null;
  //       }
  //     } else {
  //       state.deleteindices.add(index);
  //     }
  //     state.stateChanged((){});
  //   }
  // }

  // void longPress(int index) {
  //   if (state.deleteindices == null) {
  //     state.stateChanged(() {
  //       state.deleteindices = <int>[index];
  //     });
  //   }
  // }

  // void deleteButton() async {

  //   state.deleteindices.sort((n1, n2) {
  //     if(n1 <n2) return 1;
  //     else if(n1 == n2) return 0;
  //     else return -1;
  //   });

  //   for(var index in state.deleteindices) {
  //     try{
  //     await MyFireBase.deletebook(state.booklist[index]);
  //     state.booklist.removeAt(index);
  //     } catch (e) {
  //       print('BOOK DELETE ERROR: ' + e.toString());
  //     }
  //   }
  //   state.stateChanged(() {
  //     state.deleteindices = null;
  //   });
  // }

  // void sharedWithMeMenu() async{
  //   List<Book> books = await MyFireBase.getBooksSharedWithMe(state.user.email);
  //   print('# of books: ' + books.length.toString());
  //   for(var book in books) {
  //     print(book.title);
  //   }
  //   //navigate to new page
  //   await Navigator.push(state.context, MaterialPageRoute(
  //     builder: (context) => SharedBooksPage(state.user, books),
  //   ));
  //   Navigator.pop(state.context);
  // }

  void profileMenu() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(state.user),
        ));
  }

  void showMatches() {
    print(state.user.isNewMatch.toString());
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => MatchPage(state.user, state),
        ));
  }

  void showLiked() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => LikedUserPage(state.user),
        ));
  }
}
