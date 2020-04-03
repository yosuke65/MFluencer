import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/controller/matchpage_controller.dart';
import 'package:finalproject/controller/myfirebase.dart';

import '../model/user.dart';
import 'package:flutter/material.dart';

class LikedUserPage extends StatefulWidget {
  final User user;

  LikedUserPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return LikedUserPageState(user);
  }
}

class LikedUserPageState extends State<LikedUserPage> {
  User user;
  //List<Book> booklist;
  //LikedUserPageController controller;
  BuildContext context;
  List<int> deleteindices;

  LikedUserPageState(this.user) {
    user.isNewLiked = false;
    MyFireBase.updateInfo(user);
    //controller = LikedUserPageController(this);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          title: Text('Liked Users'),
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
          itemCount: user.liked.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5.0),
              color: deleteindices != null && deleteindices.contains(index)
                  ? Colors.cyan[200]
                  : Colors.lightBlueAccent[50],
              child: ListTile(
                leading: Image.network(
                    user.liked[index].imageURL),

                title: Text(user.liked[index].displayName.toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.liked[index].email.toString()),
                  ],
                ),
                // onTap: () => controller.onTap(index),
                // onLongPress: () => controller.longPress(index),
              ),
            );
          },
        ),
    );
  }
}
