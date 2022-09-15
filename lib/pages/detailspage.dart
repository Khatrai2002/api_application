import 'package:api_application/model/data.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Students data;
  const DetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details page"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage("${widget.data.avatar}"),
              radius: 80,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "First Name: ${widget.data.firstname}",
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Last Name: ${widget.data.lastname}",
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
