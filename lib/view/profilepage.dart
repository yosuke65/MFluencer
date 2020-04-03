import '../model/user.dart';
import 'package:flutter/material.dart';

import 'edituserpage.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(user);
  }
}

class ProfilePageState extends State<ProfilePage> {
  User user;

  ProfilePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserPage(user),
                  ));
            },
          ),
        ],
      ),

      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: Colors.blueAccent,
            ),
            clipper: getClipper(),
          ),
          Positioned(
            width: 425.0,
            top: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(user.imageURL),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  user.displayName,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MonteSerrat'),
                ),

                SizedBox(
                  height: 40.0,
                ),
                Text(
                  user.description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MonteSerrat'),
                ),
                // SizedBox(height: 25.0,),
                // Container(
                //   height: 30.0,
                //   width: 95.0,
                //   child: Material(
                //     borderRadius: BorderRadius.circular(20.0),
                //     shadowColor: Colors.grey,
                //     elevation: 7.0,
                //     child: GestureDetector(
                //       onTap: () {
                //         child: Center(
                //           child: Text,
                //         )
                //       },
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
      // backgroundColor: Colors.blueAccent,
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.edit), onPressed: () {}),
      //   ],
      // ),
      // body: Container(
      //   child: Column(
      //     children: <Widget>[
      //       Center(
      //         child: Container(
      //           height: 100,
      //           width: 100,
      //           margin: EdgeInsets.only(top: 50),
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             image: DecorationImage(
      //               fit: BoxFit.fill,
      //               image: AssetImage('assets/yosuke.JPG'),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Column(
      //         children: <Widget>[
      //           Container(
      //             margin: EdgeInsets.only(top: 20),
      //             child: Column(
      //               children: <Widget>[
      //                 Text(
      //                   'Username: ' + user.displayName,
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20,
      //                     fontStyle: FontStyle.italic,
      //                   ),
      //                 ),
      //                 Container(
      //                   margin: EdgeInsets.only(top: 20),
      //                 ),
      //                 Text(
      //                   'Email: ' + user.email,
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20,
      //                     fontStyle: FontStyle.italic,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(top: 20),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 123, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
