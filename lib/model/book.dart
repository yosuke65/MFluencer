class Book {

  String documentId;
  String title;
  String author;
  int pubyear;
  double price;
  String imageUrl;
  String review;
  String createdBy;
  DateTime lastUpdatedAt;
  List<dynamic> sharedWith;

  Book({
    this.title,
    this.author,
    this.pubyear,
    this.price,
    this.imageUrl,
    this.review,
    this.createdBy,
    this.lastUpdatedAt,
    this.sharedWith,
  });

  Book.empty() {
    this.title = '';
    this.author = '';
    this.pubyear = 2020;
    this.price = 0;
    this.imageUrl = '';
    this.review = '';
    this.createdBy = '';
    this.sharedWith = <dynamic>[];
  }

  Book.clone(Book b) {
    this.documentId = b.documentId;
    this.title = b.title;
    this.author = b.author;
    this.pubyear = b.pubyear;
    this.price = b.price;
    this.review = b.review;
    this.imageUrl = b.imageUrl;
    this.lastUpdatedAt = b.lastUpdatedAt;
    this.createdBy = b.createdBy;
    this.sharedWith = <dynamic>[]..addAll(b.sharedWith); //deep copy
  }

  Map<String, dynamic> serialize() {
    return <String, dynamic> {
      TITLE: title,
      AUTHOR: author,
      PUBYEAR: pubyear,
      PRICE: price,
      IMAGEURL: imageUrl,
      REVIEW: review,
      CREATEDBY: createdBy,
      LASTUPDATEAT: lastUpdatedAt,
      SHAREDWITH: sharedWith,
    };
  }

  static Book deserialize(Map<String, dynamic> data, String docId) {
    var book = Book(
      title: data[Book.TITLE],
      author: data[Book.AUTHOR],
      pubyear: data[Book.PUBYEAR],
      price: data[Book.PRICE],
      imageUrl: data[Book.IMAGEURL],
      review: data[Book.REVIEW],
      createdBy: data[Book.CREATEDBY],
      sharedWith: data[Book.SHAREDWITH],
    );
    if(data[Book.LASTUPDATEAT] != null) {
      book.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
        data[Book.LASTUPDATEAT].millisecondsSinceEpoch);
    }
    book.documentId = docId;
    return book;
  }

  static const BOOKSCOLLECTION = 'books';
  static const TITLE = 'title';
  static const AUTHOR = 'author';
  static const PUBYEAR = 'pubyear';
  static const PRICE = 'price';
  static const IMAGEURL = 'imageUrl';
  static const REVIEW = 'review';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEAT = 'lastUpdatedAt';
  static const SHAREDWITH = 'sharedWith';
}