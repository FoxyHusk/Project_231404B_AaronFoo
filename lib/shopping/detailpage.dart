// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_firestoreapp/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cartpage.dart';
import 'cartprovider.dart';

class DetailPage extends StatefulWidget {
  final String foodName;
  final String imagePath;
  final String price;

  DetailPage({
    Key? key,
    required this.foodName,
    required this.imagePath,
    required this.price,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? _selectedSize;
  int _quantity = 0;

  String get cartKey => '${widget.foodName}_${_selectedSize ?? ''}';

  String? foodQuantity;

  @override
  Widget build(BuildContext context) {
    //Inject Provider Instance
    var cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
          Hero(
            tag: widget.imagePath,
            child: SizedBox(
              height: 280, 
              width: 300, 
              child: Image.asset(widget.imagePath, height: 250),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.foodName, 
            style: const TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.price,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quantity:', 
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _quantity > 0
                  ? () {
                      setState(() {
                        _quantity--;
                      });
                      cartProvider.removeFromCart(cartKey, 1);
                    }
                  : null,
              ),
              const SizedBox(width: 20),
              Text('$_quantity', 
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _quantity < 99 
                  ? () {
                    setState(() {
                      _quantity++;
                    });
                    cartProvider.addToCart(cartKey, 1);
                  }
                  : null,
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: Icon(Icons.delivery_dining_outlined),
            label: Text('Order'),
            onPressed: _quantity == 0
              ? null
              : () async {
                  await FirestoreService().addFoodData(
                    widget.foodName,
                    widget.price,
                    _quantity.toString(),
                    '', // description placeholder, update as needed
                  );
                  Fluttertoast.showToast(msg: 'Quantity saved to Firestore', gravity: ToastGravity.TOP);
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => CartPage(),
                  );
                  Navigator.push(context, route);
                },
          ),
        ],
      ),
    );
  }
}