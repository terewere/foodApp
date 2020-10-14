import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  List basket;

  Cart(this.basket);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Image.asset(
                          widget.basket[index]['item']['imgUrl'],
                          height: 50,
                          width: 50,
                        ),
                        title: Text(
                            " ${widget.basket[index]['quantity']} 'x' ${widget.basket[index]['item']['label']}  @"),
                        trailing: Text(
                            "GHC ${widget.basket[index]['item']['price'] * widget.basket[index]['quantity']}"),
                      ),
                    );
                  },
                  itemCount: widget.basket.length),
            ),
            Text('Total : GHC 2,400.00')
          ],
        ),
      ),
    );
  }
}
