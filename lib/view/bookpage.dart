// import 'package:flutter/material.dart';
// import '../model/book.dart';
// import '../model/user.dart';
// import '../controller/bookpage_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class BookPage extends StatefulWidget {
//   final User user;
//   final Book book;

//   BookPage(this.user, this.book);

//   @override
//   State<StatefulWidget> createState() {
//     return BookPageState(user, book);
//   }
// }

// class BookPageState extends State<BookPage> {
//   User user;
//   Book book;
//   Book bookCopy;
//   BookPageController controller;
//   var formKey = GlobalKey<FormState>();

//   BookPageState(this.user, this.book) {
//     controller = BookPageController(this);
//     if (book == null) {
//       bookCopy = Book.empty();
//     } else {
//       bookCopy = Book.clone(book);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book Details'),
//       ),
//       body: Form(
//         key: formKey,
//         child: ListView(
//           children: <Widget>[
//             CachedNetworkImage(
//               imageUrl: bookCopy.imageUrl,
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) =>
//                   Icon(Icons.error_outline, size: 250),
//               height: 250,
//               width: 250,
//             ),
//             TextFormField(
//               initialValue: bookCopy.imageUrl,
//               decoration: InputDecoration(
//                 labelText: 'Image Url',
//               ),
//               autocorrect: false,
//               validator: controller.validateImageUrl,
//               onSaved: controller.saveImageUrl,
//             ),
//             TextFormField(
//               initialValue: bookCopy.title,
//               decoration: InputDecoration(
//                 labelText: 'Book Title',
//               ),
//               autocorrect: false,
//               validator: controller.validateTitle,
//               onSaved: controller.saveTitle,
//             ),
//             TextFormField(
//               initialValue: bookCopy.author,
//               decoration: InputDecoration(
//                 labelText: 'Book Author',
//               ),
//               autocorrect: false,
//               validator: controller.validateAuthor,
//               onSaved: controller.saveAuthor,
//             ),
//             TextFormField(
//               initialValue: '${bookCopy.pubyear}',
//               decoration: InputDecoration(
//                 labelText: 'Publication Year',
//               ),
//               autocorrect: false,
//               validator: controller.validatePubyear,
//               onSaved: controller.savePubyear,
//             ),
//             TextFormField(
//               initialValue: '${bookCopy.price}',
//               decoration: InputDecoration(
//                 labelText: 'Book Price',
//               ),
//               autocorrect: false,
//               validator: controller.validatePrice,
//               onSaved: controller.savePrice,
//             ),
//             TextFormField(
//               initialValue: bookCopy.sharedWith.join(',').toString(),
//               decoration: InputDecoration(
//                 labelText: 'Shared with (comma separated email list)',
//               ),
//               autocorrect: false,
//               validator: controller.validateSharedWith,
//               onSaved: controller.saveSharedWith,
//             ),
//             TextFormField(
//               maxLines: 5,
//               decoration: InputDecoration(
//                 labelText: 'review',
//               ),
//               autocorrect: false,
//               initialValue: bookCopy.review,
//               validator: controller.validateReview,
//               onSaved: controller.saveReview,
//             ),
//             Text('Created By: ' + bookCopy.createdBy),
//             Text('Last Updated At: ' + bookCopy.lastUpdatedAt.toString()),
//             Text('DocumentID: ' + bookCopy.documentId.toString()),
//             RaisedButton(
//               child: Text('Save'),
//               onPressed: controller.save,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
