import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var showError = false;

  List categories;

  @override
  void initState() {
    getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: categories == null ? CircularProgressIndicator() : gridTile()),
    );
  }

  Widget gridTile() {
    return GridView.builder(
        itemCount: categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GridTile(
            child: Column(
              children: [
                Image.network(
                  categories[index]['imgUrl'],
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                Text(categories[index]['label'])
              ],
            ),
          );
        });
  }

  void getCategories() async {
    var url = 'http://192.168.10.10/api/categories';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var categoryData = json.decode(response.body);

      categories = categoryData['data'];
      setState(() {});
    }
  }
}
