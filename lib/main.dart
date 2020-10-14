import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter/categories.dart';

import 'item_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryList(),
    );
  }
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List categories;
  List basket = [];

  void addToBasket(item, quantity) {
    setState(() {
      basket.add({'item': item, 'quantity': quantity});
    });
  }

  @override
  void initState() {
    getLocalCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          CircleAvatar(
            child: Text(basket.length.toString()),
          )
        ],
      ),
      body: Center(
          child: categories == null ? CircularProgressIndicator() : getGrid()),
    );
  }

  Widget getGrid() {
    return GridView.builder(
        itemCount: categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ItemListPage(categories[index]['id'], basket, addToBasket);
            })),
            child: Card(
              child: GridTile(
                child: ListView(
                  children: [
                    Image.asset(
                      categories[index]['imgUrl'],
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                    Text(categories[index]['label'])
                  ],
                ),
              ),
            ),
          );
        });
  }

  getCategories() async {
    var res = await http.get('http://192.168.10.10/api/categories');

    var st = jsonDecode(res.body);

    categories = st['data'];
    setState(() {});
  }

  getLocalCategories() {
    categories = categoryData;
  }
}
