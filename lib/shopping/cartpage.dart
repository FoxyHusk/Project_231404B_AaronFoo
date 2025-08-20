// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartprovider.dart';
import 'home_with_productpage.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key,}):super(key:key);

  int getFoodIndex(String cartIndex) {
    switch (cartIndex) {
      case 'Beef Satay':
        return 1;
      case 'Steamed Chicken Rice':
        return 2;
      case 'Roasted Chicken Rice':
        return 3;
      case 'Curry Fish Head Rice':
        return 4;
      case 'Beef Lasagna':
        return 5;
      case 'Hawaiian Pizza':
        return 6;
      case 'Cereal Prawn':
        return 7;
      case 'Mee Boon':
        return 8;
      default:
        return 1; // Default case if no match found
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var cart = cartProvider.cart;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeWithProductPage(),
              ),
            );
          },
        ),
        title: const Text("Shopping Cart"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text('Total: ${cartProvider.count.toString()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          String cartIndex = cart.keys.toList()[index];
          int? count = cart[cartIndex];
          var parts = cartIndex.split('_');
          String foodName = parts[0];
          String foodSize = parts.length > 1 ? parts[1] : '';
          String imagePath = "assets/images/food_${getFoodIndex(foodName)}.jpg";
            // Find price from foodName (fallback to empty string if not found)
            String price = '';
            final priceMap = {
              'Beef Satay': '2.50',
              'Steamed Chicken Rice': '2.00',
              'Roasted Chicken Rice': '2.50',
              'Curry Fish Head Rice': '7.50',
              'Beef Lasagna': '3.00',
              'Hawaiian Pizza': '2.50',
              'Cereal Prawn': '4.00',
              'Seafood Mee Hoon': '5.00',
            };
            price = priceMap[foodName] ?? '';
          return Card(
            child: _buildListCards(
              context, 
              imagePath, 
              foodName,
              price,
              foodSize, 
              count ?? 0,
              cartIndex, 
              cartProvider,
            ),
          );
        },
      ),
    );
  }
  Widget _buildListCards(
    BuildContext context, 
    String imgPath, 
    String foodName,
    String price,
    String foodSize, 
    int count, 
    String cartIndex, 
    CartProvider cartProvider) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(foodName, style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 5),
                  Text('\$ ${price}', style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  )),
                  const SizedBox(height: 5),
                  Text('Quantity: $count', style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 5),
                  // Text(
                  //   'Size: $foodSize', style: const TextStyle(
                  //   fontSize: 14.0,
                  //   fontWeight: FontWeight.bold,
                  // )),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(0), 
                right: Radius.circular(10),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              onPressed: () {
                cartProvider.clear(cartIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}