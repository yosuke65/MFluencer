import 'package:flutter/material.dart';
import './view/frontpage.dart';

void main() => runApp(BookReviewApp());

class BookReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrontPage(),
    );
  }

}