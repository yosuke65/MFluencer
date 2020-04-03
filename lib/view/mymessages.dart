import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/controller/myfirebase.dart';
import 'package:finalproject/controller/mymessages_controller.dart';
import 'package:finalproject/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Messages extends StatefulWidget {
  static const String id = "CHAT";
  final User user;
  final User matchedUser;

  Messages(this.user, this.matchedUser);

  @override
  State<StatefulWidget> createState() {
    return MessagePageState(user, matchedUser);
  }
}

class MessagePageState extends State<Messages> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  User user;
  User matchedUser;
  int index;
  MessagePageController controller;
  TextEditingController messagecontroller = TextEditingController();
  ScrollController scrollController = ScrollController();
  BuildContext context;

//   List sorted(Iterable input, [compare, key]) {
//   comparator(compare, key) {
//     if (compare == null && key == null)
//       return (a, b) => a.compareTo(b);
//     if (compare == null)
//       return (a, b) => key(a).compareTo(key(b));
//     if (key == null)
//       return compare;
//     return (a, b) => compare(key(a), key(b));
//   }
//   List copy = new List.from(input);
//   copy.sort(comparator(compare, key));
//   return copy;
// }

  Future<void> callback() async {
    index = await MyFireBase.getLastIndex(user, matchedUser);
    print('Index: ' + index.toString());
    if (messagecontroller.text.length > 0) {
      index++;
      await _firestore
          .collection(User.PROFILE_COLLECTION)
          .document(user.uid)
          .collection('Match')
          .document(matchedUser.uid)
          .collection('message')
          .add({
        'text': messagecontroller.text,
        'from': user.email,
        'me': true,
        'index': index,
        // 'to': user.matches,
      });

      index++;
      await _firestore
          .collection(User.PROFILE_COLLECTION)
          .document(matchedUser.uid)
          .collection('Match')
          .document(user.uid)
          .collection('message')
          .add({
        'text': messagecontroller.text,
        'from': user.email,
        'me': false,
        'index': index,
        // 'to': user.matches,
      });
      messagecontroller.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  MessagePageState(this.user, this.matchedUser) {
    controller = MessagePageController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(matchedUser.displayName.toString()),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection(User.PROFILE_COLLECTION)
                      .document(user.uid)
                      .collection('Match')
                      .document(matchedUser.uid)
                      .collection('message')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    List<DocumentSnapshot> docs = snapshot.data.documents;
                    //print(snapshot.data.documents.toString());

                    //List<Widget> messages = docs
                    List<Msg> messages = docs
                        .map((doc) => Msg(
                              from: doc.data['from'],
                              text: doc.data['text'],
                              me: user.email == doc.data['from'],
                              index: doc.data['index'],
                            ))
                        .toList();
                    
                    //Sort Messages in order
                    messages.sort((a, b) => a.index.compareTo(b.index));



                    print('Messages length: ' + messages.length.toString());
                    //  for (var message in messages) {
                    //    print('Message: '+message);
                    //  }
                    return ListView(
                      //reverse: true,
                      controller: scrollController,
                      children: <Widget>[
                        ...messages,
                      ],
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter a Message ...",
                          border: const OutlineInputBorder(),
                        ),
                        controller: messagecontroller,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(10),
                      child: SendButton(
                        text: 'Send',
                        callback: callback,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: callback,
      child: Text(text, style: TextStyle(color: Colors.white),),
    );
  }
}

class Msg extends StatelessWidget {
  final String from;
  final String text;
  final int index;
  final bool me;

  const Msg({Key key, this.from, this.text, this.me, this.index}) : super(key: key);

  static Msg deserialize(Map<String, dynamic> document) {
    return Msg(
      from: document[FROM],
      text: document[TEXT],
      me: document[ME],
      index: document[INDEX],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
          ),
          Material(
            color: me ? Colors.blue[400] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: me ? Colors.grey[100].withOpacity(1) : Colors.black.withOpacity(0.9),
                  fontWeight: FontWeight.w600
                  ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static const TEXT = 'text';
  static const FROM = 'from';
  static const ME = 'me';
  static const INDEX = 'index';
}
