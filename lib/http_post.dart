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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (namaC.text == "" && jobC.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Isi form data!!")));
                  } else {
                    var responsePost = await http.post(
                      Uri.parse("https://reqres.in/api/users"),
                      body: {
                        "name": namaC.text,
                        "job": jobC.text,
                      },
                    );
                    Map<String, dynamic> dataResponPost =
                        json.decode(responsePost.body) as Map<String, dynamic>;
                    // print(dataRespon["name"]);
                    setState(() {
                      hasilResponse =
                          "${dataResponPost['name']} - ${dataResponPost['job']} [POST]";
                    });
                  }
                },
                child: const Text("POST"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var responseGet = await http.get(
                    Uri.parse("https://reqres.in/api/users/2"),
                  );
                  // print(responseGet.body);
                  Map<String, dynamic> dataResponGet =
                      json.decode(responseGet.body) as Map<String, dynamic>;
                  // print(dataRespon["name"]);
                  setState(() {
                    hasilResponse =
                        "${dataResponGet['data']['first_name']} ${dataResponGet['data']['last_name']}- ${dataResponGet['data']['email']} [GET]";
                  });
                },
                child: const Text("GET"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var responsePut = await http.put(
                    Uri.parse("https://reqres.in/api/users/2"),
                    body: {
                      "name": namaC.text,
                      "job": jobC.text,
                    },
                  );
                  Map<String, dynamic> dataResponPut =
                      json.decode(responsePut.body) as Map<String, dynamic>;
                  // print(dataRespon["name"]);
                  setState(() {
                    hasilResponse =
                        "${dataResponPut['name']} - ${dataResponPut['job']} [GET]";
                  });
                },
                child: const Text("PUT"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var responseDelete = await http.delete(
                    Uri.parse("https://reqres.in/api/users/2"),
                  );
                  if (responseDelete.statusCode == 204) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Delete berhasil"),
                      ),
                    );
                  }
                  setState(() {
                    hasilResponse = "Respon ${responseDelete.statusCode}";
                  });
                },
                child: const Text("DELETE"),
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              hasilResponse,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
