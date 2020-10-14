import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter/item_details.dart';
import 'package:rest_api_flutter/items.dart';

class ItemListPage extends StatefulWidget {
  final categoryId;

  List basket;
  Function addToBasket;

  ItemListPage(this.categoryId, this.basket, this.addToBasket);

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List items;

  void addToBasket(item, quantity) {
    setState(() {
      widget.addToBasket(item, quantity);
    });
  }

  @override
  void initState() {
    getLocalItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('items'),
        actions: [
          CircleAvatar(
            child: Text(widget.basket.length.toString()),
          )
        ],
      ),
      body: Center(child: items == null ? Container() : getGrid()),
    );
  }

  Widget getGrid() {
    return GridView.builder(
        itemCount: items.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ItemDetails(items[index], widget.basket, addToBasket);
              }));
            },
            child: Card(
              child: GridTile(
                child: Column(
                  children: [
                    Image.asset(
                      items[index]['imgUrl'],
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                    Text(items[index]['label']),
                  ],
                ),
              ),
            ),
          );
        });
  }

  getItems() async {
    var res = await http.get('http://192.168.10.10/api/categories');

    var st = jsonDecode(res.body);

    items = st['data'];
    setState(() {});
  }

  getLocalItems() {
    items = itemsData
        .where((item) => item['categoryId'] == widget.categoryId)
        .toList();
  }
}
