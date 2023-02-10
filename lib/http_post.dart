import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPost extends StatefulWidget {
  const HttpPost({Key? key}) : super(key: key);

  @override
  State<HttpPost> createState() => _HttpPostState();
}

class _HttpPostState extends State<HttpPost> {
  TextEditingController namaC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  String hasilResponse = "BELUM ADA DATA!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HTTP POST",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: namaC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              var response = await http.post(
                Uri.parse("https://reqres.in/api/users"),
                body: {
                  "name": namaC.text,
                  "job": jobC.text,
                },
              );
              Map<String, dynamic> dataRespon =
                  json.decode(response.body) as Map<String, dynamic>;
              // print(dataRespon["name"]);
              setState(() {
                hasilResponse = "${dataRespon['name']} - ${dataRespon['job']}";
              });
            },
            child: const Text("Submid"),
          ),
          const SizedBox(height: 50),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(hasilResponse),
          ),
        ],
      ),
    );
  }
}
