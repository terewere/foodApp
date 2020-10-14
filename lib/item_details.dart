import 'package:flutter/material.dart';

import 'cart.dart';

class ItemDetails extends StatefulWidget {
  var item;
  List basket;
  Function addToBasket;

  ItemDetails(this.item, this.basket, this.addToBasket);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  var quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              child: Text(widget.basket.length.toString()),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return Cart(widget.basket);
              }));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Image.asset(widget.item['imgUrl']),
          Text(widget.item['label']),
          Text('GHC' + widget.item['price'].toString()),
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (quantity == 1) {
                      return;
                    }
                    quantity -= 1;
                  });
                },
                child: Text('-'),
              ),
              Text(quantity.toString()),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    quantity += 1;
                  });
                },
                child: Text('+'),
              ),
              Text(
                'GHC' + (widget.item['price'] * quantity).toStringAsFixed(2),
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          RaisedButton(
            child: Text('Add to Basket'),
            onPressed: () {
              setState(() {
                widget.addToBasket(widget.item, quantity);
              });
            },
          )
        ],
      ),
    );
  }
}
