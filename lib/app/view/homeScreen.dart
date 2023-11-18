import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final API = 'https://meal.rifatewu.xyz/api/data';
  List months = [];
  Future loadMonths() async {
    var response = await http.get(Uri.parse(API));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);

      setState(() {
        months = items;
      });
      return months;
    } else {
      throw Exception('Failed to load months');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: FutureBuilder(
        future: loadMonths(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: months.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sheets',
                      arguments: months[index]['sheetId']);
                },
                child: ListTile(
                  title: Text(months[index]['name']),
                  subtitle: Text(months[index]['sheetId']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
