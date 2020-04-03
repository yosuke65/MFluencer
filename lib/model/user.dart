

import 'package:finalproject/model/connection.dart';

class User {
  String email;
  String password;
  String displayName;
  String userType;
  // int zip;
  String uid;
  String imageURL;
  String description;
  List<User> matches;
  List<User> liked;
  bool isNewLiked;
  bool isNewMatch;
  // bool yap;
  // bool nope;

  Connection connection;

  User({
    this.email,
    this.password,
    this.displayName,
    this.userType,
    // this.zip,
    this.uid,
    this.imageURL,
    this.description,
    this.connection,
    this.isNewLiked,
    this.isNewMatch,
  });

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      EMAIL: email,
      DISPLAYNAME: displayName,
      USERTYPE: userType,
      // ZIP: zip,
      UID: uid,
      IMAGEURL: imageURL,
      DESCRIPTION: description,
      ISNEWLIKED: isNewLiked,
      ISNEWMATCH: isNewMatch,
    };
  }

  //   Map<String, dynamic> connectionSerialize() {
  //   return <String, dynamic>{
  //     YAP: yap,
  //     NOPE: nope,
  //     UID: uid,
  //     ISNEWLIKED: isNewLiked,
  //     ISNEWMATCH: isNewMatch,
  //   };
  // }

  Map<String, dynamic> leftSwipe(uid1) {
    return <String, dynamic> {
      YAP: false,
      NOPE: true,
      UID: uid1,
      // ISNEWLIKED: false,
      // ISNEWMATCH: false,
    };
  }

    Map<String, dynamic> rightSwipe(uid1) {
    return <String, dynamic> {
      YAP: true,
      NOPE: false,
      UID: uid1,
      // ISNEWLIKED: true,
      // ISNEWMATCH: false,
    };
  }

  //     Map<String, dynamic> match() {
  //   return <String, dynamic> {
  //     YAP: true,
  //     NOPE: false,
  //     MATCH: true,
  //   };
  // }

  // static Data sendData(Map<String, dynamic> document) {
  //   return Data(
  //     yap: document[YAP],
  //     nope: document[NOPE],
  //     match: document[MATCH],
  //   );
  // }



  static User deserialize(Map<String, dynamic> document) {
    return User(
      email: document[EMAIL],
      displayName: document[DISPLAYNAME],
      userType: document[USERTYPE],
      // zip: document[ZIP],
      uid: document[UID],
      imageURL: document[IMAGEURL],
      description: document[DESCRIPTION],
      isNewLiked: document[ISNEWLIKED],
      isNewMatch: document[ISNEWMATCH],
    );
  }

  //   static Connection connectionDeserialize(Map<String, dynamic> document) {
  //   return Connection(
  //     yap: document[YAP],
  //     nope: document[NOPE],
  //     uid: document[UID],
  //     isNewLiked: document[ISNEWLIKED],
  //     isNewMatch: document[ISNEWMATCH],
  //   );
  // }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const DISPLAYNAME = 'displayname';
  static const USERTYPE = 'userType';
  // static const ZIP = 'zip';
  static const UID = 'uid';
  static const IMAGEURL = 'imageURL';
  static const DESCRIPTION = 'description';

  static const YAP = 'yap';
  static const NOPE = 'nope';
  static const MATCH = 'match';
  static const ISNEWMATCH = 'isNewMatch';
  static const ISNEWLIKED = 'isNewLiked';

}