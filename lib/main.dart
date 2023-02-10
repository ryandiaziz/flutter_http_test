import 'package:flutter/material.dart';
import 'package:flutter_http_test/http_get.dart';
import 'package:flutter_http_test/http_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HttpPost(),
    );
  }
}
