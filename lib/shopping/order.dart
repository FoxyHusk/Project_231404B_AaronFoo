// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'productpage.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Text('Start an order', style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          )),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 60,
                        alignment: Alignment.center,
                        child: Icon(Icons.storefront, size: 50, color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Pickup', style: TextStyle(
                          fontSize: 16.0, 
                          fontWeight: FontWeight.bold,
                        )),
                        Text('Pick up your food at the restaurant', style: TextStyle(
                          fontSize: 14.0, 
                          color: Colors.grey,
                        )),
                      ]
                    ),
                  ),
                ]
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductPage()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 60,
                        alignment: Alignment.center,
                        child: Icon(Icons.delivery_dining, size: 50, color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Delivery', style: TextStyle(
                          fontSize: 16.0, 
                          fontWeight: FontWeight.bold,
                        )),
                        Text('Get your food delivered to your doorstep', style: TextStyle(
                          fontSize: 14.0, 
                          color: Colors.grey,
                        )),
                      ]
                    ),
                  ),
                ]
              ),
            ],
          ), 
        ],
      ),
    );
  }
}