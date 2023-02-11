import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestFutureBuilder extends StatefulWidget {
  const TestFutureBuilder({Key? key}) : super(key: key);

  @override
  State<TestFutureBuilder> createState() => _TestFutureBuilderState();
}

class _TestFutureBuilderState extends State<TestFutureBuilder> {
  List<Map<String, dynamic>> allUsers = [];
  Future getAllUsers() async {
    try {
      var response = await http.get(Uri.parse("https://reqres.in/api/users"));
      List data = (json.decode(response.body) as Map<String, dynamic>)['data'];
      data.forEach((element) {
        allUsers.add(element);
      });
      print(allUsers);
    } catch (e) {
      //print jika terjadi kesalahan
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Builder"),
      ),
      body: FutureBuilder(
        future: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${allUsers[index]['avatar']}",
                  ),
                ),
                title: Text(
                    "${allUsers[index]['first_name']} ${allUsers[index]['last_name']}"),
                subtitle: Text("${allUsers[index]['email']}"),
              ),
            );
          }
        },
      ),
    );
  }
}