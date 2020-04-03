class Connection {
  bool yap;
  bool nope;
  String uid;
  bool isNewMatch;
  bool isNewLiked;

  Connection({
    this.yap = false,
    this.nope = false,
    this.uid,
    this.isNewLiked,
    this.isNewMatch,
    //this.match
  });


  // Map<String, dynamic> leftSwipe(String uid1) {
  //   return <String, dynamic> {
  //     YAP: false,
  //     NOPE: true,
  //     UID: uid1
  //   };
  // }

  //   Map<String, dynamic> rightSwipe(String uid1) {
  //   return <String, dynamic> {
  //     YAP: true,
  //     NOPE: false,
  //     UID: uid1
  //   };
  // }


  static Connection deserialize(Map<String, dynamic> document) {
    return Connection(
      yap: document[YAP],
      nope: document[NOPE],
      uid: document[UID],
      isNewLiked: document[ISNEWLIKED],
      isNewMatch: document[ISNEWMATCH],
      //match: document[MATCH],
    );
  }

  static const YAP = 'yap';
  static const NOPE = 'nope';
  static const UID = 'uid';
  static const ISNEWLIKED = 'isNewLiked';
  static const ISNEWMATCH = 'isNewMatch';

  //static const MATCH = 'match';
}