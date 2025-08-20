// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'detailpage.dart';
import 'cartpage.dart';
import 'cartprovider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}):super(key:key);

  final _foodName = [
    'Beef Satay',
    'Steamed Chicken Rice',
    'Roasted Chicken Rice',
    'Curry Fish Head Rice',
    'Beef Lasagna',
    'Hawaiian Pizza',
    'Ceral Prawn',
    'Seafood Mee Hoon',
  ];

  final _foodPrice = [
    '\$2.50',
    '\$2.00',
    '\$2.50',
    '\$7.50',
    '\$3.00',
    '\$2.50',
    '\$4.00',
    '\$5.00',
  ];

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Products Page'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0), 
            child: SizedBox(
              height: 150.0,
              width: 30.0,
              child: InkWell(
                splashColor: Colors.redAccent,
                highlightColor: Colors.blueAccent.withOpacity(0.5),
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart, 
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.brightness_1,
                            size: 20.0,
                            color: Colors.red[700],
                          ),
                          Positioned(
                            top: 3.0,
                            right: 7,
                            child: Center(
                              child: Text(
                                cartProvider.count.toString(), 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(8, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    foodName: _foodName[index],
                    imagePath: 'assets/images/food_${index + 1}.jpg',
                    price: _foodPrice[index],
                  )
                ),
              );
            },
            child: _buildGridCards(
              context, 
              'assets/images/food_${index + 1}.jpg', 
              _foodName[index], 
              _foodPrice[index]),
          );
        }),
      ),
    );
  }

  Widget _buildGridCards(
    BuildContext context, 
    String imgPath, 
    String foodName, 
    String foodPrice) {
    return Card(
      // color: Colors.lightBlueAccent,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath), 
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Text(foodName, style: TextStyle(
            fontSize: 16.0, 
            fontWeight: FontWeight.bold,
          )),
          Text(foodPrice, style: TextStyle(
            fontSize: 14.0, 
            color: Colors.grey,
          )),
        ],
      ),
    );
  }
}