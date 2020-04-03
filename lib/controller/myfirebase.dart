import 'dart:io';

import 'package:finalproject/model/connection.dart';
import 'package:finalproject/view/mymessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/user.dart';
import '../model/book.dart';
import 'package:path/path.dart' as Path;

class MyFireBase {
  static FirebaseStorage storage = new FirebaseStorage(
      storageBucket: 'gs://mfluencer-finalproj-47a3f.appspot.com/');

  static Future<String> createAccount({String email, String password}) async {
    AuthResult auth =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return auth.user.uid;
  }

  static void createProfile(User user) async {
    print('CreateProfile called');
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());
    print(user.displayName);
    print(user.email);
    print(user.uid);
    print(user.userType);
    print(user.imageURL);
  }

  static void swipLeft(User currentUser, User swipedUser) async {
    currentUser.imageURL = await getUserImage(currentUser);
    swipedUser.imageURL = await getUserImage(swipedUser);
    print('current user image: ' + currentUser.imageURL);
    print('swiped user image: ' + swipedUser.imageURL);
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(currentUser.uid)
        .collection('Connection')
        .document(swipedUser.uid)
        .setData(currentUser.leftSwipe(swipedUser.uid));
  }

  static void swipRight(User currentUser, User swipedUser) async {
    currentUser.imageURL = await getUserImage(currentUser);
    swipedUser.imageURL = await getUserImage(swipedUser);
    print('current user image: ' + currentUser.imageURL);
    print('swiped user image: ' + swipedUser.imageURL);
    Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(currentUser.uid)
        .collection('Connection')
        .document(swipedUser.uid)
        .setData(currentUser.rightSwipe(swipedUser.uid));

    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(swipedUser.uid)
        .collection('Liked')
        .document(currentUser.uid)
        .setData(currentUser.serialize());
  }

  static Future<String> getUserImage(User user) async {
    try {
      if (user.imageURL !=
              'https:dongthinh.org/wp-content/uploads/2015/11/avatar.jpg') {
        // FirebaseStorage storage = new FirebaseStorage(
        //     storageBucket: 'gs://mfluencer-finalproj-47a3f.appspot.com/');
        StorageReference imageLink = storage.ref().child(user.imageURL);
        String imageURL = await imageLink.getDownloadURL();
        print('Print Success*********************************');
        return imageURL;
      } else {
        return 'https:dongthinh.org/wp-content/uploads/2015/11/avatar.jpg';
      }
    } catch (e) {
      return 'https:dongthinh.org/wp-content/uploads/2015/11/avatar.jpg';
    }
  }

  static Future<void> updateInfo(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());
  }

  static void registerMatch(User currentUser, User swipedUser) async {
    currentUser.imageURL = await getUserImage(currentUser);
    swipedUser.imageURL = await getUserImage(swipedUser);
    print('current user image: ' + currentUser.imageURL);
    print('swiped user image: ' + swipedUser.imageURL);
    Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(currentUser.uid)
        .collection('Match')
        .document(swipedUser.uid)
        .setData(swipedUser.serialize());

    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(swipedUser.uid)
        .collection('Match')
        .document(currentUser.uid)
        .setData(currentUser.serialize());

    // Firestore.instance
    //     .collection(User.PROFILE_COLLECTION)
    //     .document(currentUser.uid)
    //     .collection('Connection')
    //     .document(swipedUser.uid)
    //     .setData(currentUser.match());

    // await Firestore.instance
    //     .collection(User.PROFILE_COLLECTION)
    //     .document(swipedUser.uid)
    //     .collection('Connection')
    //     .document(currentUser.uid)
    //     .setData(currentUser.match());
  }

  static Future<Connection> isMatch(User currentUser, User swipedUser) async {
    Connection connection;
    DocumentSnapshot doc = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(swipedUser.uid)
        .collection('Connection')
        .document(currentUser.uid)
        .get();

    if (doc.data != null) {
      print('isMatch Firebase: ' + doc.data.toString());
      return Connection.deserialize(doc.data);
    } else {
      print('Doc data is null');
      return connection;
    }
  }

  static Future<String> login({String email, String password}) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static Future<User> readProfile(String uid) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(uid)
        // .collection(userType)
        // .document(uid)
        .get();
    print('Read proflie');
    return User.deserialize(doc.data);
  }

  //   static Future<User> readMatchedProfile(String uid) async {
  //   DocumentSnapshot doc = await Firestore.instance
  //       .collection(User.PROFILE_COLLECTION)
  //       .document(uid)
  //       .collection(userType)
  //       .document(uid)
  //       .get();
  //   print('Read proflie');
  //   return User.deserialize(doc.data);
  // }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static Future<QuerySnapshot> getDataCollection() {
    return Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .getDocuments();
  }

  static Stream<QuerySnapshot> streamDataCollection() {
    return Firestore.instance.collection(User.PROFILE_COLLECTION).snapshots();
  }

  static Future<void> updateProfile(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());
  }

  // static Future<String> addBook(Book book) async {
  //   DocumentReference ref = await Firestore.instance
  //       .collection(Book.BOOKSCOLLECTION)
  //       .add(book.serialize());
  //   return ref.documentID;
  // }

  static Future<List<User>> getUsers() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .getDocuments();
    var userlist = <User>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return userlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      userlist.add(User.deserialize(doc.data));
    }
    return userlist;
  }

  static Future<int> getLastIndex(User user, matchedUser) async {
    int lastindex = 0;
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .collection('Match')
        .document(matchedUser.uid)
        .collection('message')
        .getDocuments();
    var messages = <Msg>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return 0;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      messages.add(Msg.deserialize(doc.data));
    }

    lastindex = messages[0].index;
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].index > lastindex) {
        lastindex = messages[i].index;
      }
    }
    return lastindex;
  }

  static Future<List<Connection>> getConnections(User user) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .collection('Connection')
        .getDocuments();
    var connectionlist = <Connection>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return connectionlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      connectionlist.add(Connection.deserialize(doc.data));
    }
    return connectionlist;
  }

  static Future<List<User>> getBrands() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .where(User.USERTYPE, isEqualTo: 'Brand')
        .getDocuments();
    var userlist = <User>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return userlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      userlist.add(User.deserialize(doc.data));
    }
    return userlist;
  }

  static Future<List<User>> getInfluencers() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .where(User.USERTYPE, isEqualTo: 'Influencer')
        .getDocuments();
    var userlist = <User>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return userlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      userlist.add(User.deserialize(doc.data));
    }
    return userlist;
  }

  static Future<List<User>> getMatches(User user) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .collection('Match')
        .getDocuments();
    var matches = <User>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return matches;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      matches.add(User.deserialize(doc.data));
    }
    return matches;
  }

  static Future<List<User>> getLikedUser(User user) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .collection('Liked')
        .getDocuments();
    var liked = <User>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return liked;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      liked.add(User.deserialize(doc.data));
    }
    return liked;
  }

  static Future<List<Msg>> getMessage(User user, User matchedUser) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .collection('Match')
        .document(matchedUser.uid)
        .collection('message')
        .getDocuments();
    var message = <Msg>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return message;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      message.add(Msg.deserialize(doc.data));
    }
    return message;
  }

  // static Future<List<Book>> getBooks(String email) async {
  //   QuerySnapshot querySnapshot = await Firestore.instance
  //       .collection(Book.BOOKSCOLLECTION)
  //       .where(Book.CREATEDBY, isEqualTo: email)
  //       .getDocuments();
  //   var booklist = <Book>[];
  //   if (querySnapshot == null || querySnapshot.documents.length == 0) {
  //     return booklist;
  //   }
  //   for (DocumentSnapshot doc in querySnapshot.documents) {
  //     booklist.add(Book.deserialize(doc.data, doc.documentID));
  //   }
  //   return booklist;
  // }

  // static Future<void> updateBook(Book book) async {
  //   await Firestore.instance
  //       .collection(Book.BOOKSCOLLECTION)
  //       .document(book.documentId)
  //       .setData(book.serialize());
  // }

  // static Future<void> deletebook(Book book) async {
  //   await Firestore.instance
  //       .collection(Book.BOOKSCOLLECTION)
  //       .document(book.documentId)
  //       .delete();
  // }

  // static Future<List<Book>> getBooksSharedWithMe(String email) async {
  //   try {
  //     QuerySnapshot querySnapshot = await Firestore.instance
  //         .collection(Book.BOOKSCOLLECTION)
  //         .where(Book.SHAREDWITH, arrayContains: email)
  //         .orderBy(Book.CREATEDBY)
  //         .orderBy(Book.LASTUPDATEAT)
  //         .getDocuments();
  //     var books = <Book>[];
  //     if (querySnapshot == null || querySnapshot.documents.length == 0) {
  //       return books;
  //     }
  //     for (DocumentSnapshot doc in querySnapshot.documents) {
  //       books.add(Book.deserialize(doc.data, doc.documentID));
  //     }
  //     return books;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
