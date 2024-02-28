
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
void fatchUsers() async{
  const url = "https://randomuser.me/api/?results=100";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
  setState((){
  users =json['results'];
  });
  print("fatchUsers completed");


}

void initState(){
  super.initState();
  fatchUsers();
}

  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Example'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          final user = users[index];
          final name = user['name']['first']; 
          final email = user['email'];
          final color = user['gender'] == 'male' ? Colors.blue : Colors.pink;
          final imageUrl = user['picture']['thumbnail'];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(imageUrl)),
          title : Text(name),
          subtitle : Text(email),
          tileColor: color,
        );
      }),
      floatingActionButton:FloatingActionButton(
        onPressed: fatchUsers),

    );
  }
}


