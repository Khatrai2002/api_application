import 'package:api_application/model/data.dart';
import 'package:api_application/pages/detailspage.dart';
import 'package:api_application/utils/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String baseurl = 'https://630e0a16109c16b9abf34867.mockapi.io';
  List<Students> user = [];

  bool _isLoading = true;
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Api Demo"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  getUsers();
                },
                child: const Icon(Icons.rotate_left)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          data: user[index],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${user[index].avatar}"),
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          Text("${user[index].firstname}"),
                          Text("${user[index].lastname}"),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            deletStudentApi(user[index].id);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void getUsers() async {
    setState(() {
      _isLoading = true;
    });
    http.Response res = await http.get(Uri.parse("${Appconfig.url}/users"));
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      user = [];
      decoded.forEach((v) {
        user.add(Students(
          id: v['id'],
          firstname: v['firstname'],
          lastname: v['lastname'],
          avatar: v['avatar'],
        ));
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  deletStudentApi(String? id) async {
    http.Response res =
        await http.delete(Uri.parse("${Appconfig.url}/users/$id"));
    if (res.statusCode == 200) {
      getUsers();
    }
  }
 
}
