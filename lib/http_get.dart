import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class HttpGet extends StatefulWidget {
  const HttpGet({Key? key}) : super(key: key);

  @override
  State<HttpGet> createState() => _HttpGetState();
}

class _HttpGetState extends State<HttpGet> {
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID = $id",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "EMAIL = $email",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "NAME = $name",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                var response = await myhttp.get(
                  Uri.parse("https://reqres.in/api/users/2"),
                );

                if (response.statusCode == 200) {
                  Map<String, dynamic> data =
                      jsonDecode(response.body) as Map<String, dynamic>;

                  print(data["data"]);
                  setState(() {
                    id = data["data"]["id"].toString();
                    email = data["data"]["email"].toString();
                    name =
                        "${data["data"]["first_name"]} ${data["data"]["last_name"]}";
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Berhasil GET Data",
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "ERROR ${response.statusCode}",
                      ),
                    ),
                  );
                }
              },
              child: const Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
