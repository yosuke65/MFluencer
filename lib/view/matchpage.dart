import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/controller/matchpage_controller.dart';
import 'package:finalproject/controller/myfirebase.dart';
import 'package:finalproject/view/homepage.dart';

import '../model/user.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  final User user;
  final HomePageState state;

  MatchPage(this.user, this.state);

  @override
  State<StatefulWidget> createState() {
    return MatchPageState(user, state);
  }
}

class MatchPageState extends State<MatchPage> {
  User user;
  HomePageState state;
  //List<Book> booklist;
  MatchPageController controller;
  BuildContext context;
  List<int> deleteindices;

  MatchPageState(this.user, this.state) {
    controller = MatchPageController(this);
    state.user.isNewMatch = false;
    MyFireBase.updateInfo(user);
    print('isNewMatch state changed to false');
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Matched Users'),
        // actions: deleteindices == null
        //     ? null
        //     : <Widget>[
        //         FlatButton.icon(
        //           label: Text('Delete'),
        //           icon: Icon(Icons.delete),
        //           onPressed: controller.deleteButton,
        //         ),
        //       ],
      ),
      // drawer: Drawer(
      //     child: ListView(
      //   children: <Widget>[
      //     UserAccountsDrawerHeader(
      //       accountName: Text(user.displayName),
      //       accountEmail: Text(user.email),
      //       currentAccountPicture: Container(
      //           decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               image: DecorationImage(
      //                   fit: BoxFit.fill,
      //                   image: ExactAssetImage(
      //                       'assets/images/${user.imageURL}')))),
      //     ),
      //                 ListTile(
      //       leading: Icon(Icons.people),
      //       title: Text('Home'),
      //       onTap: controller.homepage,
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.people),
      //       title: Text('Profile'),
      //       onTap: controller.profileMenu,
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.people),
      //       title: Text('Matches'),
      //       onTap: controller.showMatches,
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.exit_to_app),
      //       title: Text('Sign Out'),
      //       onTap: controller.signOut,
      //     ),
      //   ],
      // )),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: controller.addButton,
      // ),
      body: ListView.builder(
        itemCount: user.matches.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(5.0),
            color: deleteindices != null && deleteindices.contains(index)
                ? Colors.cyan[200]
                : Colors.lightBlueAccent[50],
            child: ListTile(
              // leading: CircleAvatar(
              //     radius: 30,
              //     child: ClipOval(
              //         child: Image.asset(
              //       'assets/images/${user.matches[index].imageURL}',
              //       width: 50,
              //       height: 50,
              //       fit: BoxFit.cover,
              //     ))),
              leading: GestureDetector(
                child: Image.network(
                    user.matches[index].imageURL,
                    width: 60,
                    height: 60),
                //onTap: () => controller.onTap(user.matches[index]),
              ),
              title: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(user.matches[index].displayName.toString())),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(user.matches[index].email.toString()),
                      ],
                    ),
                  ]),
              trailing: IconButton(
                icon: Icon(Icons.message),
                color: Colors.lightBlue,
                onPressed: () => controller.myMessages(user.matches[index]),
                alignment: Alignment.bottomLeft,
              ),

              onTap: () => controller.onTap(user.matches[index]),
              // onLongPress: () => controller.longPress(index),
            ),
          );
        },
      ),
    );
  }
}
