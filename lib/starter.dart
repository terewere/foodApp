import 'package:flutter/material.dart';

class Starter extends StatefulWidget {
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List _tabs = [
      Text('tab 1'),
      Text('tab 2'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hanbali'),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text('Basket'), icon: Icon(Icons.shopping_cart)),
        ],
      ),
    );
  }
}
