import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/book.dart';
import '../model/user.dart';

class SharedBooksPage extends StatelessWidget {
  final User user;
  final List<Book> books;

  SharedBooksPage(this.user, this.books);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(5.0),
          color: Colors.lime,
          child: Card(
            color: Colors.lime[100],
            elevation: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: books[index].imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                  Text('${books[index].title}'),
                  Text('Author: ${books[index].title}'),
                  Text('Publication Year: ${books[index].pubyear}'),
                  Text(
                    'Review: ${books[index].review}',
                    style: TextStyle(fontSize:20, color: Colors.teal),
                  ),
                  Text('Created By: ${books[index].createdBy}'),
                  Text('Last Updated at: ${books[index].lastUpdatedAt}'),
                  Text('Shared With: ${books[index].sharedWith}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
