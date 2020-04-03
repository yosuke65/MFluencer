import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import '../controller/homepage_controller.dart';

class HomePage extends StatefulWidget {
  final User user;
  final List<User> userlist;
  final List<User> brandlist;
  final List<User> influencerlist;

  HomePage(this.user, this.userlist, this.brandlist, this.influencerlist);
  @override
  State<StatefulWidget> createState() {
    return HomePageState(user, userlist, brandlist, influencerlist);
  }
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  User user;
  bool swipeLeft;
  bool swipeRight;
  List<User> userlist;
  List<User> brandlist;
  List<User> influencerlist;
  HomePageController controller;
  // BuildContext context;
  // List<int> deleteindices;

  HomePageState(this.user, this.userlist, this.brandlist, this.influencerlist) {
    controller = HomePageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(title: Text('User Home')),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName),
            accountEmail: Text(user.email),
            currentAccountPicture: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            user.imageURL)))),
          ),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Profile'),
            onTap: controller.profileMenu,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Matches'),
            trailing: user.isNewMatch
                ? Container(
                  margin: EdgeInsets.only(right: 130),
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  )
                : Container(
                  margin: EdgeInsets.only(right: 130),
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
            onTap: controller.showMatches,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Liked'),
            trailing: user.isNewLiked
                ? Container(
                  margin: EdgeInsets.only(right: 150),
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  )
                : Container(
                  margin: EdgeInsets.only(right:150),
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
            onTap: controller.showLiked,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: controller.signOut,
          ),
        ],
      )),
      body: Center(
        child: new Stack(
          children: <Widget>[
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  child: new TinderSwapCard(
                      orientation: AmassOrientation.BOTTOM,
                      totalNum: user.userType == 'Brand'
                          ? influencerlist.length
                          : brandlist.length,
                      stackNum: 3,
                      swipeEdge: 4.0,
                      maxWidth: MediaQuery.of(context).size.width * 1,
                      maxHeight: MediaQuery.of(context).size.width * 1,
                      minWidth: MediaQuery.of(context).size.width * .8,
                      minHeight: MediaQuery.of(context).size.width * .8,
                      cardBuilder: (context, index) => Card(
                            // child: Image.asset('${welcomeImages[index]}'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                user.userType == 'Brand'
                                    ? Image.network(
                                        influencerlist[index].imageURL,width: 500,height: 250,)
                                    : Image.network(
                                        brandlist[index].imageURL,width: 500,height: 250),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          user.userType == 'Brand'
                                              ? Text(
                                                  influencerlist[index]
                                                      .displayName,
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  brandlist[index].displayName,
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Description: ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            user.userType == 'Brand'
                                                ? Text(
                                                    influencerlist[index]
                                                        .description,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                : Text(
                                                    brandlist[index]
                                                        .description,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        /// Get swiping card's alignment
                        if (align.x < 0) {
                          //Card is LEFT swiping
                          swipeLeft = true;
                          swipeRight = false;
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                          swipeLeft = false;
                          swipeRight = true;
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        if (swipeLeft) {
                          if (user.userType == 'Influencer') {
                            controller.swipeLeft(brandlist[index]);
                          } else {
                            controller.swipeLeft(influencerlist[index]);
                          }
                        }
                        if (swipeRight) {
                          if (user.userType == 'Influencer') {
                            controller.swipeRight(brandlist[index]);
                            controller.isMatch(brandlist[index], context);
                          } else {
                            controller.swipeRight(influencerlist[index]);
                            controller.isMatch(influencerlist[index], context);
                          }
                        }

                        /// Get orientation & index of swiped card!
                      })),
            ),
            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       controller.matchAnimation();
            //       },
            //     child: AnimatedDefaultTextStyle(
            //       duration: const Duration(milliseconds: 200),
            //       style:
            //          isMatched
            //          ?
            //           TextStyle(
            //               fontSize: 50,
            //               color: Colors.red,
            //               fontWeight: FontWeight.bold,
            //               )
            //           :
            //           TextStyle(
            //               color: Color(0x00000000)
            //           ),
            //       child: Text(
            //         'Match',
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class UserList extends StatelessWidget {

//   List<User> userlist;
//   UserList(this.userlist);
//   @override
//   Widget build(BuildContext context) {
//     return new StreamBuilder(
//         stream:
//             Firestore.instance.collection(User.PROFILE_COLLECTION).snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           print('Userlist Called');
//           if (snapshot.hasData) {
//             userlist = snapshot.data.documents
//                 .map((doc) => User.deserialize(doc.data))
//                 .toList();
//             print('UserList');
//             print(userlist);
//           }
//         });
//   }
//}
